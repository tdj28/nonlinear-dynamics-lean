"""Regression tests for the context-aware teaching-source checker."""

from __future__ import annotations

import unittest

try:
    from scripts.check_teaching_source_hygiene import build_source_masks, check_text
    from scripts.check_public_reader_language import check_public_text
except ModuleNotFoundError:
    # ``unittest discover -s scripts`` puts scripts/ itself on sys.path.
    from check_teaching_source_hygiene import build_source_masks, check_text
    from check_public_reader_language import check_public_text


PASS_CASES = {
    "balanced inline and display math": (
        r"A point \(x\) and a display \[f(x) = x^2.\]"
    ),
    "valid TeX line-break spacing": (
        r"\[\begin{aligned} a &= b \\[4pt] c &= d \end{aligned}\]"
    ),
    "escaped TeX commands": (
        r"\(\lVert A\rVert \qquad \mathbb{R},\; i \in \iota(I),\; "
        r"\operatorname{tr}(A)\)"
    ),
    "ordinary iota prose": "The iota coordinate labels the inclusion.",
    "fenced source contexts": r"""
```lean
\(<\)
=
—
lVert mathbb operatorname
```

Rendered \(x\).
""",
    "tilde fenced source context": r"""
~~~text
\[not rendered\]
$$x$$
~~~
""",
    "blockquote fenced source context": r"""
> ```lean
> \(<\)
> =
> ```
""",
    "inline code context": r"Use `\\(x\\)`, `lVert`, `$x$`, and `—` literally.",
    "multiline inline code context": "Use `\\(<\n=\n\\)` literally.",
    "HTML comment context": r"Before <!-- \(<\) = lVert — --> after.",
    "Hugo comment context": r"Before {{/* \(<\) = lVert — */}} after.",
    "HTML code and pre contexts": r"""
<code>\(<\) = lVert —</code>
<pre class="sample">\[<\]
=
operatorname</pre>
""",
    "YAML front matter": r"""---
title: "\\(not math\\)"
marker: =
command: lVert
---
Body \(x\).
""",
    "shortcode attributes": (
        r"{{< refterm key=\"\\(x\\)\" label=\"lVert\" >}}term"
        r"{{< /refterm >}}"
    ),
    "Markdown shortcode body remains balanced": r"""
{{< panel "info" >}}
The body contains \(x\).
{{< /panel >}}
""",
    "raw Mermaid shortcode body": r"""
{{< mermaid >}}
flowchart LR
  A[\(<\)] --> B["lVert — $$x$$"]
  =
{{< /mermaid >}}
""",
    "quoted em dash with straight double quotes": 'She wrote, "A — B," exactly.',
    "quoted em dash with curly double quotes": "She wrote, “A — B,” exactly.",
    "quoted em dash with curly single quotes": "She wrote, ‘A — B,’ exactly.",
    "quoted em dash with guillemets": "She wrote, «A — B», exactly.",
    "blockquote em dash": "> This source is quoted — verbatim.\n",
    "currency dollar amounts": (
        "The cache costs $1.60; compare $5 and $10 or the $5-$10 range."
    ),
    "shell variables are not paired math": "Use $HOME and $PATH for these paths.",
    "escaped dollar signs": r"Write \$x\$ literally.",
    "masked escape corruption": (
        "---\ncommand: lVert\n---\n"
        "`\x08egin{bmatrix}` <!-- iiniota --> "
        "<code>operatorname</code>"
    ),
    "precise evidentiary register": (
        "The example illustrates the definition. "
        "This counterexample refutes the reverse implication. "
        "The calculation checks the finite case. "
        "The proof establishes the general theorem."
    ),
    "example states its existential role": (
        "This example proves the existence of a fixed point. "
        "The second example establishes that there is at least one "
        "nonconstant solution. "
        "A third example proves an existential claim. "
        "The fourth example proves there exists a periodic point. "
        "The fifth example establishes a periodic point exists."
    ),
    "model states its logical role": (
        "This finite model establishes consistency of the axioms. "
        "The second model proves that the axioms are consistent."
    ),
    "proof claim inside code is literal": (
        "Use `the example proves the claim` only as a quoted bad pattern."
    ),
}


FAIL_CASES = {
    "unclosed inline delimiter": (r"Before \(x after.", {"unclosed-delimiter"}),
    "unclosed display delimiter": (r"Before \[x after.", {"unclosed-delimiter"}),
    "unmatched closer": (r"Before x\) after.", {"unmatched-delimiter"}),
    "mismatched delimiter": (r"Before \(x\] after.", {"mismatched-delimiter"}),
    "nested delimiters": (r"\(x + \[y\]\)", {"nested-delimiter"}),
    "double escaped opener": (
        r"Before \\(x\\) after.",
        {"double-escaped-delimiter"},
    ),
    "literal less-than in TeX": (r"\(x < y\)", {"literal-angle-in-tex"}),
    "literal greater-than in TeX": (r"\[x > y\]", {"literal-angle-in-tex"}),
    "rendered lone equals": ("Before\n=\nAfter\n", {"lone-equals"}),
    "blockquote lone equals": ("> before\n> =\n> after\n", {"lone-equals"}),
    "inline code cannot open rendered math": (
        "`\\(`\nRendered \\)\n",
        {"unmatched-delimiter"},
    ),
    "HTML comment cannot open rendered math": (
        "<!-- \\( --> Rendered \\)",
        {"unmatched-delimiter"},
    ),
    "shortcode attribute cannot open rendered math": (
        "{{< refterm label=\"\\(\" >}} Rendered \\)",
        {"unmatched-delimiter"},
    ),
    "Markdown shortcode body is checked": (
        r"{{< panel >}}\(<\){{< /panel >}}",
        {"literal-angle-in-tex"},
    ),
    "prose em dash": ("A — B", {"em-dash"}),
    "em dash after quotation": ('"A B" — commentary', {"em-dash"}),
    "front matter quote is metadata not a quotation": (
        '---\ntitle: "A — B"\n---\nBody.\n',
        {"em-dash"},
    ),
    "shortcode quote is syntax not a quotation": (
        '{{< panel title="A — B" >}}Body{{< /panel >}}',
        {"em-dash"},
    ),
    "bare inline dollar math": ("Use $x+y$ here.", {"bare-dollar-math"}),
    "bare numeric dollar math": ("Use $2+2$ here.", {"bare-dollar-math"}),
    "bare display dollar math": ("Use $$x+y$$ here.", {"bare-dollar-math"}),
    "C0 backspace": (
        r"\(" + "\x08" + r"egin{bmatrix}1\end{bmatrix}\)",
        {"c0-control"},
    ),
    "dropped lVert": (r"\(lVert A\)", {"dropped-tex-backslash"}),
    "dropped rVert": (r"\(A rVert\)", {"dropped-tex-backslash"}),
    "dropped qquad": (r"\(A qquad B\)", {"dropped-tex-backslash"}),
    "dropped ldots in a sequence": (
        r"\((A_0,A_1,A_2,ldots)\)",
        {"dropped-tex-backslash"},
    ),
    "fused in and iota": (r"\(iniota\)", {"dropped-tex-backslash"}),
    "fused variable in and iota": (r"\(iiniota\)", {"dropped-tex-backslash"}),
    "dropped begin remnant": (
        r"\(egin{bmatrix}1\end{bmatrix}\)",
        {"dropped-tex-backslash"},
    ),
    "dropped mathbb": (r"\(mathbb{R}\)", {"dropped-tex-backslash"}),
    "dropped operatorname": (
        r"\(operatorname{tr}(A)\)",
        {"dropped-tex-backslash"},
    ),
    "example credited with proof": (
        "The interval example proves that the reverse arrow is invalid.",
        {"epistemic-overreach"},
    ),
    "counterexample uses a generic proof verb": (
        "This counterexample proves that the reverse implication is false.",
        {"epistemic-overreach"},
    ),
    "worksheet credited with establishment": (
        "This worksheet establishes the general identity.",
        {"epistemic-overreach"},
    ),
    "figure credited with validation": (
        "The figure validates the theorem.",
        {"epistemic-overreach"},
    ),
    "picture credited with proof": (
        "This picture proves the general claim.",
        {"epistemic-overreach"},
    ),
    "plate credited with a nonclaim": (
        "The plate proves no independence or asymptotic theorem.",
        {"epistemic-overreach"},
    ),
    "probe credited with proof": (
        "The compiled probe proves the assumption necessary.",
        {"epistemic-overreach"},
    ),
    "model credited with proof": (
        "This finite model establishes the theorem.",
        {"epistemic-overreach"},
    ),
    "front-matter lead credited with proof": (
        '---\nlead: "This example proves the result."\n---\nBody.\n',
        {"epistemic-overreach"},
    ),
    "shortcode caption credited with proof": (
        '{{< reference-figure caption="This diagram proves the theorem." >}}',
        {"epistemic-overreach"},
    ),
    "example cannot prove nonexistence by generic phrasing": (
        "This example proves that there is no counterexample.",
        {"epistemic-overreach"},
    ),
    "example cannot prove zero witnesses by generic phrasing": (
        "This example establishes that there are zero solutions.",
        {"epistemic-overreach"},
    ),
    "example cannot vaguely validate existence": (
        "This example validates the existence of a fixed point.",
        {"epistemic-overreach"},
    ),
}


class TeachingSourceHygieneTests(unittest.TestCase):
    def test_accepted_sources(self) -> None:
        for name, source in PASS_CASES.items():
            with self.subTest(name=name):
                self.assertEqual([], check_text(source))

    def test_rejected_sources(self) -> None:
        for name, (source, expected_codes) in FAIL_CASES.items():
            with self.subTest(name=name):
                issues = check_text(source)
                actual_codes = {issue.code for issue in issues}
                self.assertTrue(
                    expected_codes <= actual_codes,
                    f"expected {expected_codes}, got {issues}",
                )

    def test_masking_preserves_offsets_and_newlines(self) -> None:
        source = r"""---
title: \(masked\)
---
`also \(masked\)`
Rendered \(x\).
"""
        masks = build_source_masks(source)
        self.assertEqual(len(source), len(masks.rendered))
        self.assertEqual(len(source), len(masks.style))
        self.assertEqual(
            [index for index, char in enumerate(source) if char == "\n"],
            [index for index, char in enumerate(masks.rendered) if char == "\n"],
        )

    def test_diagnostic_line_survives_masked_contexts(self) -> None:
        source = "---\ntitle: \\(masked\\)\n---\n`\\(masked\\)`\nRendered \\(x\n"
        issues = check_text(source)
        unclosed = [issue for issue in issues if issue.code == "unclosed-delimiter"]
        self.assertEqual(1, len(unclosed))
        self.assertEqual(5, unclosed[0].line)


class PublicReaderLanguageTests(unittest.TestCase):
    def test_reader_facing_resource_language_is_accepted(self) -> None:
        source = (
            "Standalone tutorial: run this Lean core example on macOS or Linux.\n"
            "Full project check: install the pinned Lean and Mathlib dependencies, "
            "then run `lake env lean NonlinearDynamics/Example.lean`.\n"
            "The eigenvalue lies in the cloud of sample points.\n"
            "Check whether the eigenvalue lies in the cloud of sample points.\n"
            "Test whether it remains in the cloud of sample points.\n"
            "Point-cloud validation compares empirical spectra.\n"
            "The sample-cloud project maps eigenvalues to nearby bins.\n"
            "Make a final check that the theorem statement is accurate.\n"
            "The command will make setup easier.\n"
            "This will make Lean explanations accessible."
        )
        self.assertEqual([], check_public_text(source))

    def test_contributor_infrastructure_language_is_rejected(self) -> None:
        samples = (
            "Put the worksheet in that approved Linux environment.",
            "Run this only on the human-approved cloud builder.",
            "CLOUD_LEAN_BUILD=1 make lean-file",
            "Run make check from the repository root.",
            "Run make -j1 check from the repository root.",
            "Run make -J8 lean to build the formalization.",
            "Run make -j 1 check from the repository root.",
            "Run make --jobs=1 lean-file for a leaf module.",
            "Run make --jobs 8 setup before compiling.",
            "Run make -s -j4 workstation-check before publishing.",
            "Run make -C . check from the repository root.",
            "Run make --directory . lean to compile the project.",
            "Run make LEAN_FILE=Foo.lean lean-file for a leaf module.",
            "Use make lean to build the formalization.",
            "Do not run this on the workstation.",
            "This worksheet was executed on the Mac.",
            "The broader Linux release gate is separate.",
            "Use the RunPod cache.",
            "Preview it over Tailscale.",
            "This is a cloud-only project check.",
            "Run the cloud probe below.",
            "Run the cloud commands below.",
            "The cloud validation is authoritative.",
            "Wait for cloud approval before building.",
            "Run the full project in the cloud.",
            "Use a cloud machine for this check.",
            "The remote compute builder is authoritative.",
            "Use the guarded release command.",
            "Use the guarded Linux command.",
            "Use the guarded Make targets.",
            "Replay the internal release gate.",
            "Do not run the project on the Mac.",
            "Serve the preview over the tailnet.",
            "Use MagicDNS for the preview.",
            "Restore the retained cache from the network volume.",
        )
        for source in samples:
            with self.subTest(source=source):
                self.assertTrue(check_public_text(source))

    def test_portable_linux_host_language_is_accepted(self) -> None:
        self.assertEqual(
            [],
            check_public_text(
                "Run this standalone tutorial on a normal Mac or Linux host."
            ),
        )


if __name__ == "__main__":
    unittest.main()
