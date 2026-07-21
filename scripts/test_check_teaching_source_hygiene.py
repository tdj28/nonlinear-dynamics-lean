"""Regression tests for the context-aware teaching-source checker."""

from __future__ import annotations

import unittest

try:
    from scripts.check_teaching_source_hygiene import build_source_masks, check_text
except ModuleNotFoundError:
    # ``unittest discover -s scripts`` puts scripts/ itself on sys.path.
    from check_teaching_source_hygiene import build_source_masks, check_text


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


if __name__ == "__main__":
    unittest.main()
