"""Regression cases for failures ordinary Hugo link resolution misses."""

from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

from check_rendered_site import ROOT, RenderedPage, audit_output


class RenderedSiteTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)

    def write(self, path: str, source: str = "") -> None:
        target = self.root / path
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(source, encoding="utf-8")

    def errors(self, base: str = "https://site-check.invalid/") -> list[str]:
        return audit_output(self.root, base)[0]

    def test_valid_relative_query_encoded_fragment_and_assets(self) -> None:
        self.write("index.html", '<a href="chapter/?view=all#two%20words">Chapter</a>')
        self.write("chapter/index.html", '<h1 id="two words">Chapter</h1><img src="figure%20one.svg"><a href="../">Home</a>')
        self.write("chapter/figure one.svg", "<svg/>")
        self.assertEqual([], self.errors())

    def test_stale_fragment_fails(self) -> None:
        self.write("index.html", '<a href="#camp-four">Read</a><h2 id="camp-five">Cases</h2>')
        self.assertTrue(any("missing HTML fragment" in e for e in self.errors()))

    def test_tex_parsed_as_markdown_link_fails(self) -> None:
        self.write("index.html", '<a href="%5Comega">f</a>')
        self.assertTrue(any("missing local target" in e for e in self.errors()))

    def test_missing_image_and_social_image_fail(self) -> None:
        self.write("index.html", '<img src="missing.svg"><meta property="og:image" content="https://site-check.invalid/card.png">')
        self.assertEqual(2, len(self.errors()))

    def test_external_links_and_non_http_schemes_are_not_fetched(self) -> None:
        self.write("index.html", '<a href="https://example.org/missing">External</a><a href="mailto:a@example.org">Email</a><img src="data:image/png;base64,AAAA">')
        self.assertEqual([], self.errors())

    def test_subpath_links_must_stay_under_deployment_root(self) -> None:
        self.write("index.html", '<a href="/project/chapter/">Good</a><a href="/chapter/">Bad</a>')
        self.write("chapter/index.html", "<h1>Chapter</h1>")
        errors = self.errors("https://site-check.invalid/project/")
        self.assertEqual(1, len(errors))
        self.assertIn("escapes base path", errors[0])

    def test_percent_encoded_parent_traversal_fails(self) -> None:
        self.write("index.html", '<a href="/%2e%2e/outside">Bad</a>')
        self.assertTrue(any("escapes output" in e for e in self.errors()))

    def test_text_fragment_and_legacy_named_anchor(self) -> None:
        self.write("index.html", '<a name="reference"></a><a href="#reference:~:text=words">Legacy</a><a href="#:~:text=words">Text</a>')
        self.assertEqual([], self.errors())

    def test_empty_output_fails(self) -> None:
        self.assertEqual(["No HTML pages found in Hugo output"], self.errors())

    def test_double_escaped_bridge_delimiters_fail(self) -> None:
        self.write("index.html", r'<article class="lean-bridge-paper"><div>\\(f(\\omega)\\)</div></article>')
        self.assertTrue(any("double-escaped TeX" in e for e in self.errors()))

    def test_native_tex_and_linebreak_spacing_survive(self) -> None:
        self.write("index.html", r'<article class="lean-bridge-paper"><div>\[\begin{aligned}a\\[4pt]b\end{aligned}\]</div></article>')
        self.assertEqual([], self.errors())

    @unittest.skipUnless(shutil.which("hugo"), "Hugo is required for template regression")
    def test_real_template_preserves_native_and_legacy_tex(self) -> None:
        inline = r"\(\mathbb E_\mu[f\mid\mathcal I_T](\omega).\)"
        aligned = r"\[\begin{aligned}a&=b\\[4pt]c&=d\end{aligned}\]"
        expressions = [inline, inline.replace("\\", "\\\\"), aligned, aligned.replace("\\", "\\\\")]
        body = "---\ntitle: Fixture\n---\n"
        for expression in expressions:
            body += '{{< lean-bridge human="Equality" math="' + expression + '" lean="example : True := by trivial" >}}{{< /lean-bridge >}}\n'
        self.write("fixture/content/_index.md", body)
        self.write("fixture/hugo.yaml", "baseURL: https://fixture.invalid/\ndisableKinds: [taxonomy, term, RSS, sitemap]\n")
        self.write("fixture/layouts/home.html", "{{ .Content }}")
        template = self.root / "fixture/layouts/shortcodes/lean-bridge.html"
        template.parent.mkdir(parents=True)
        shutil.copyfile(ROOT / "site/layouts/shortcodes/lean-bridge.html", template)
        result = subprocess.run(
            ["hugo", "--source", str(self.root / "fixture"), "--destination", str(self.root / "output"), "--panicOnWarning", "--noBuildLock"],
            capture_output=True, text=True,
        )
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        page = RenderedPage((self.root / "output/index.html").read_text())
        formulas = [math.strip().removeprefix("On paper").strip() for math in page.bridge_math]
        self.assertEqual([inline, inline, aligned, aligned], formulas)
        self.assertEqual([], page.links)


if __name__ == "__main__":
    unittest.main()
