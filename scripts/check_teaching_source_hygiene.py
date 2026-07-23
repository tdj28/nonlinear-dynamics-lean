#!/usr/bin/env python3
"""Check rendered teaching prose for Markdown and TeX source hazards.

The checker first replaces non-rendered source contexts with spaces while
preserving every offset and newline.  Diagnostics therefore refer to the
original source even though YAML, code, comments, and shortcode syntax cannot
accidentally open or close a math delimiter.
"""

from __future__ import annotations

from dataclasses import dataclass
import re
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CONTENT_ROOT = ROOT / "site" / "content"

_IGNORE_RENDERED = 1
_IGNORE_STYLE = 2
_IGNORE_LITERAL = _IGNORE_RENDERED | _IGNORE_STYLE

_FENCE_OPEN = re.compile(
    r"^[ \t]*(?:>[ \t]*)*(?:(?:[-+*]|\d+[.)])[ \t]+)?"
    r"(?P<fence>`{3,}|~{3,})"
)
_HTML_CODE_OPEN = re.compile(r"<\s*(?P<tag>code|pre)\b", re.IGNORECASE)
_MATH_TOKEN = re.compile(r"(?<!\\)(?P<slashes>\\+)(?P<token>[()\[\]])")
_LONE_EQUALS = re.compile(r"^[ \t]*(?:>[ \t]*)*=[ \t]*$")
_EVIDENTIARY_OVERREACH = re.compile(
    r"\b(?P<subject>counterexamples?|examples?|models?|worksheets?|figures?|"
    r"diagrams?|pictures?|charts?|visuals?|plates?|plots?|tables?|"
    r"countermodels?|probes?|outputs?|commands?|simulations?|experiments?|"
    r"compilers?|compilations?|elaborators?|elaborations?)\s+"
    r"(?:alone\s+)?(?P<verb>proves?|proved|establish(?:es|ed)?|"
    r"validates?|validated)\b",
    re.IGNORECASE,
)
_EXPLICIT_EXISTENTIAL_ROLE = re.compile(
    r"^\s+(?:(?:the|an?)\s+)?"
    r"(?:existence|existential\s+(?:claim|statement))\b|"
    r"^\s+(?:that\s+)?there\s+(?:exists?|is|are)\b"
    r"(?!\s+(?:no|not|zero|none|neither|0\b)\b)|"
    r"^\s+(?:the|an?|some)\s+[^.!?\n]{1,80}\s+exists?\b",
    re.IGNORECASE,
)
_EXPLICIT_MODEL_ROLE = re.compile(
    r"^\s+(?:(?:the|an?)\s+)?(?:consistency|satisfiability)\b|"
    r"^\s+that\s+[^.!?\n]{1,80}\s+(?:is|are)\s+"
    r"(?:consistent|satisfiable)\b",
    re.IGNORECASE,
)
_AMBIGUOUS_UNIFORM_EXPERIMENT = re.compile(
    r"\b(?:the|a)\s+uniform\s+experiment\s+"
    r"(?:can|could|may|might)\s+"
    r"(?:produce|return|attain|hit)\b",
    re.IGNORECASE,
)

# These are deliberately conservative.  They are command names (or fused
# command remnants) with little plausible use as ordinary mathematical prose.
_DROPPED_TEX_PATTERNS: tuple[re.Pattern[str], ...] = (
    re.compile(
        r"(?<![\\A-Za-z0-9_])"
        r"(?:lVert|rVert|langle|rangle|ldots|cdots|qquad|infty)\b"
    ),
    re.compile(r"(?<![\\A-Za-z0-9_])(?:mathbb|mathcal|operatorname)\b"),
    re.compile(
        r"(?<![\\A-Za-z0-9_])"
        r"(?:egin|begin|end|frac|sqrt|mathbf|mathrm|text)\s*\{"
    ),
    re.compile(r"(?<![A-Za-z0-9_])(?:iniota|iiniota)\b"),
    re.compile(
        r"(?<![\\A-Za-z0-9_])(?:left|right)"
        r"(?:lVert|rVert|langle|rangle)\b"
    ),
)


@dataclass(frozen=True)
class SourceIssue:
    """One source-hygiene diagnostic."""

    code: str
    message: str
    offset: int
    line: int


@dataclass(frozen=True)
class SourceMasks:
    """Offset-preserving views used by the rendered and style checks."""

    rendered: str
    style: str
    flags: tuple[int, ...]


def project_path(path: Path) -> str:
    return path.relative_to(ROOT).as_posix()


def line_number(text: str, offset: int) -> int:
    return text.count("\n", 0, offset) + 1


def _issue(text: str, code: str, message: str, offset: int) -> SourceIssue:
    return SourceIssue(code, message, offset, line_number(text, offset))


def _mark(flags: list[int], start: int, end: int, kind: int) -> None:
    for index in range(start, min(end, len(flags))):
        flags[index] |= kind


def _line_bounds(text: str, start: int) -> tuple[int, int]:
    """Return the line end without and with its newline."""

    newline = text.find("\n", start)
    if newline == -1:
        return len(text), len(text)
    end = newline - 1 if newline > start and text[newline - 1] == "\r" else newline
    return end, newline + 1


def _front_matter_end(text: str) -> int:
    first_end, first_next = _line_bounds(text, 0)
    if text[:first_end] != "---":
        return 0

    cursor = first_next
    while cursor < len(text):
        line_end, next_line = _line_bounds(text, cursor)
        if text[cursor:line_end] in {"---", "..."}:
            return next_line
        cursor = next_line
    return len(text)


def _fence_at(text: str, start: int) -> tuple[str, int, int] | None:
    line_end, next_line = _line_bounds(text, start)
    line = text[start:line_end]
    match = _FENCE_OPEN.match(line)
    if match is None:
        return None
    fence = match.group("fence")
    if fence[0] == "`" and "`" in line[match.end() :]:
        return None
    return fence[0], len(fence), next_line


def _fence_end(text: str, cursor: int, marker: str, width: int) -> int:
    closing = re.compile(
        rf"^[ \t]*(?:>[ \t]*)*{re.escape(marker)}{{{width},}}[ \t]*$"
    )
    while cursor < len(text):
        line_end, next_line = _line_bounds(text, cursor)
        if closing.fullmatch(text[cursor:line_end]):
            return next_line
        cursor = next_line
    return len(text)


def _matching_backtick_run(text: str, start: int, width: int) -> int | None:
    cursor = start + width
    while cursor < len(text):
        tick = text.find("`", cursor)
        if tick == -1:
            return None
        end = tick
        while end < len(text) and text[end] == "`":
            end += 1
        if end - tick == width:
            return end
        cursor = end
    return None


def _html_tag_end(text: str, start: int) -> int:
    quote: str | None = None
    cursor = start
    while cursor < len(text):
        char = text[cursor]
        if quote is not None:
            if char == quote:
                quote = None
        elif char in {'"', "'"}:
            quote = char
        elif char == ">":
            return cursor + 1
        cursor += 1
    return len(text)


def _shortcode_end(text: str, start: int) -> tuple[int, str, bool] | None:
    if text.startswith("{{<", start):
        terminator = ">}}"
    elif text.startswith("{{%", start):
        terminator = "%}}"
    else:
        return None

    close = text.find(terminator, start + 3)
    if close == -1:
        return len(text), "", False

    end = close + len(terminator)
    inner = text[start + 3 : close].strip()
    closing = inner.startswith("/")
    name_match = re.match(r"/?\s*([A-Za-z0-9_-]+)", inner)
    name = name_match.group(1).lower() if name_match else ""
    return end, name, closing


def _mermaid_end(text: str, body_start: int) -> int:
    closing = re.compile(r"{{[<%]\s*/\s*mermaid\s*[>%]}}", re.IGNORECASE)
    match = closing.search(text, body_start)
    return match.end() if match is not None else len(text)


def build_source_masks(text: str) -> SourceMasks:
    """Mask non-rendered contexts without changing source length or lines."""

    flags = [0] * len(text)
    front_matter_end = _front_matter_end(text)
    if front_matter_end:
        _mark(flags, 0, front_matter_end, _IGNORE_RENDERED)

    cursor = front_matter_end
    while cursor < len(text):
        if cursor == 0 or text[cursor - 1] == "\n":
            fence = _fence_at(text, cursor)
            if fence is not None:
                marker, width, body_start = fence
                end = _fence_end(text, body_start, marker, width)
                _mark(flags, cursor, end, _IGNORE_LITERAL)
                cursor = end
                continue

        if text.startswith("<!--", cursor):
            close = text.find("-->", cursor + 4)
            end = len(text) if close == -1 else close + 3
            _mark(flags, cursor, end, _IGNORE_LITERAL)
            cursor = end
            continue

        if text.startswith("{{/*", cursor):
            close = text.find("*/}}", cursor + 4)
            end = len(text) if close == -1 else close + 4
            _mark(flags, cursor, end, _IGNORE_LITERAL)
            cursor = end
            continue

        shortcode = _shortcode_end(text, cursor)
        if shortcode is not None:
            tag_end, name, closing = shortcode
            if name == "mermaid" and not closing:
                end = _mermaid_end(text, tag_end)
                _mark(flags, cursor, end, _IGNORE_LITERAL)
                cursor = end
                continue
            _mark(flags, cursor, tag_end, _IGNORE_RENDERED)
            cursor = tag_end
            continue

        if text[cursor] == "<":
            html_open = _HTML_CODE_OPEN.match(text, cursor)
            if html_open is not None:
                tag = html_open.group("tag")
                open_end = _html_tag_end(text, html_open.end())
                if text[cursor:open_end].rstrip().endswith("/>"):
                    end = open_end
                else:
                    closing = re.compile(rf"</\s*{tag}\s*>", re.IGNORECASE)
                    close_match = closing.search(text, open_end)
                    end = close_match.end() if close_match is not None else len(text)
                _mark(flags, cursor, end, _IGNORE_LITERAL)
                cursor = end
                continue

        if text[cursor] == "`":
            run_end = cursor
            while run_end < len(text) and text[run_end] == "`":
                run_end += 1
            end = _matching_backtick_run(text, cursor, run_end - cursor)
            if end is not None:
                _mark(flags, cursor, end, _IGNORE_LITERAL)
                cursor = end
                continue
            cursor = run_end
            continue

        cursor += 1

    def masked(kind: int) -> str:
        return "".join(
            char if not flags[index] & kind or char in "\r\n" else " "
            for index, char in enumerate(text)
        )

    return SourceMasks(
        rendered=masked(_IGNORE_RENDERED),
        style=masked(_IGNORE_STYLE),
        flags=tuple(flags),
    )


def _is_escaped(text: str, offset: int) -> bool:
    slashes = 0
    cursor = offset - 1
    while cursor >= 0 and text[cursor] == "\\":
        slashes += 1
        cursor -= 1
    return slashes % 2 == 1


def _quote_spans(line: str) -> list[tuple[int, int]]:
    spans: list[tuple[int, int]] = []
    for opening, closing in (("“", "”"), ("‘", "’"), ("«", "»")):
        cursor = 0
        while True:
            start = line.find(opening, cursor)
            if start == -1:
                break
            end = line.find(closing, start + 1)
            if end == -1:
                break
            spans.append((start, end))
            cursor = end + 1

    quotes = [
        index
        for index, char in enumerate(line)
        if char == '"' and not _is_escaped(line, index)
    ]
    spans.extend(zip(quotes[::2], quotes[1::2]))
    return spans


def _check_em_dashes(text: str, masks: SourceMasks) -> list[SourceIssue]:
    issues: list[SourceIssue] = []
    offset = 0
    for line in masks.style.splitlines(keepends=True):
        visible = line.rstrip("\r\n")
        quote_spans = _quote_spans(visible)
        is_blockquote = re.match(r"^[ \t]*(?:>[ \t]*)+", visible) is not None
        for column, char in enumerate(visible):
            if char != "\N{EM DASH}":
                continue
            source_offset = offset + column
            is_rendered = not masks.flags[source_offset] & _IGNORE_RENDERED
            in_quote = any(start < column < end for start, end in quote_spans)
            if not (is_rendered and (is_blockquote or in_quote)):
                issues.append(
                    _issue(
                        text,
                        "em-dash",
                        "em dash is allowed only inside a Markdown blockquote or "
                        "same-line paired quotation marks",
                        source_offset,
                    )
                )
        offset += len(line)
    return issues


def _check_controls_and_dropped_tex(
    text: str, rendered: str
) -> list[SourceIssue]:
    issues: list[SourceIssue] = []
    for offset, char in enumerate(rendered):
        if ord(char) < 32 and char not in {"\t", "\n"}:
            issues.append(
                _issue(
                    text,
                    "c0-control",
                    f"C0 control character U+{ord(char):04X} in rendered source",
                    offset,
                )
            )

    for pattern in _DROPPED_TEX_PATTERNS:
        for match in pattern.finditer(rendered):
            issues.append(
                _issue(
                    text,
                    "dropped-tex-backslash",
                    f"{match.group()!r} looks like a TeX command missing its "
                    "leading backslash",
                    match.start(),
                )
            )
    return issues


def _check_lone_equals(text: str, rendered: str) -> list[SourceIssue]:
    issues: list[SourceIssue] = []
    offset = 0
    for line in rendered.splitlines(keepends=True):
        visible = line.rstrip("\r\n")
        if _LONE_EQUALS.fullmatch(visible):
            equality = visible.find("=")
            issues.append(
                _issue(
                    text,
                    "lone-equals",
                    "lone '=' can become a Goldmark Setext heading; write '{} =' "
                    "inside TeX",
                    offset + equality,
                )
            )
        offset += len(line)
    return issues


def _check_evidentiary_register(
    text: str, style: str
) -> list[SourceIssue]:
    """Reject subjects that are generically credited with proof-level force."""

    issues: list[SourceIssue] = []
    for match in _EVIDENTIARY_OVERREACH.finditer(style):
        subject = match.group("subject").lower()
        verb = match.group("verb").lower()
        suffix = style[match.end() :]
        # A concrete witness can establish an existential statement, and a
        # model can establish consistency or satisfiability. Preserve those
        # standard logical roles while rejecting generic proof attribution and
        # the nonspecific verb "validate."
        admits_logical_role = subject in {
            "example",
            "examples",
            "model",
            "models",
            "countermodel",
            "countermodels",
        }
        if admits_logical_role and not verb.startswith("validat"):
            if _EXPLICIT_EXISTENTIAL_ROLE.match(suffix):
                continue
        if (
            not verb.startswith("validat")
            and subject in {"model", "models", "countermodel", "countermodels"}
        ):
            if _EXPLICIT_MODEL_ROLE.match(suffix):
                continue
        issues.append(
            _issue(
                text,
                "epistemic-overreach",
                "imprecise evidentiary attribution; name the object's exact "
                "logical role or credit the proof or argument",
                match.start(),
            )
        )
    return issues


def _check_uniform_experiment_modality(
    text: str, style: str
) -> list[SourceIssue]:
    """Reject the original high-signal uniform-experiment wording."""

    return [
        _issue(
            text,
            "ambiguous-uniform-experiment",
            "state the canonical sample map, its fiber, and the fiber's mass "
            "instead of saying that a uniform experiment can produce a value",
            match.start(),
        )
        for match in _AMBIGUOUS_UNIFORM_EXPERIMENT.finditer(style)
    ]


def _check_tex_delimiters(text: str, rendered: str) -> list[SourceIssue]:
    issues: list[SourceIssue] = []
    stack: list[tuple[str, int, int]] = []

    for match in _MATH_TOKEN.finditer(rendered):
        slashes = match.group("slashes")
        token = match.group("token")
        token_offset = match.start()

        # Within math, two backslashes can be an ordinary TeX line break, as
        # in ``\\[4pt]``.  Outside math the same source is a strong signal that
        # a Markdown math delimiter was accidentally double escaped.
        if len(slashes) > 1:
            if not stack:
                issues.append(
                    _issue(
                        text,
                        "double-escaped-delimiter",
                        f"double-escaped math delimiter {match.group()!r}",
                        match.start(),
                    )
                )
                continue
            if len(slashes) % 2 == 0:
                continue
            # An odd run inside math is a sequence of TeX line breaks followed
            # by one real delimiter.  Attribute any diagnostic to that final
            # backslash rather than the beginning of the run.
            token_offset += len(slashes) - 1

        if token in "([":
            if stack:
                issues.append(
                    _issue(
                        text,
                        "nested-delimiter",
                        "nested TeX math delimiter",
                        token_offset,
                    )
                )
            stack.append((token, token_offset, match.end()))
            continue

        expected = "(" if token == ")" else "["
        if not stack:
            issues.append(
                _issue(
                    text,
                    "unmatched-delimiter",
                    "closing TeX delimiter has no matching opener",
                    token_offset,
                )
            )
            continue

        opener, opener_offset, body_start = stack.pop()
        if opener != expected:
            issues.append(
                _issue(
                    text,
                    "mismatched-delimiter",
                    "closing TeX delimiter does not match its opener",
                    token_offset,
                )
            )
            continue

        body = rendered[body_start : match.start()]
        angle = min(
            (position for position in (body.find("<"), body.find(">")) if position >= 0),
            default=-1,
        )
        if angle >= 0:
            issues.append(
                _issue(
                    text,
                    "literal-angle-in-tex",
                    "literal '<' or '>' inside TeX; use \\lt or \\gt",
                    body_start + angle,
                )
            )

    for _opener, opener_offset, _body_start in stack:
        issues.append(
            _issue(
                text,
                "unclosed-delimiter",
                "TeX delimiter is not closed",
                opener_offset,
            )
        )
    return issues


def _check_bare_dollars(text: str, rendered: str) -> list[SourceIssue]:
    issues: list[SourceIssue] = []
    line_offset = 0
    for line in rendered.splitlines(keepends=True):
        visible = line.rstrip("\r\n")
        singles: list[int] = []
        cursor = 0
        while cursor < len(visible):
            if visible[cursor] != "$" or _is_escaped(visible, cursor):
                cursor += 1
                continue
            end = cursor + 1
            while end < len(visible) and visible[end] == "$":
                end += 1
            if end - cursor >= 2:
                issues.append(
                    _issue(
                        text,
                        "bare-dollar-math",
                        "bare '$$' math delimiter is disabled; use \\[...\\]",
                        line_offset + cursor,
                    )
                )
            else:
                singles.append(cursor)
            cursor = end

        opener: int | None = None
        for position in singles:
            previous = visible[position - 1] if position > 0 else ""
            following = visible[position + 1] if position + 1 < len(visible) else ""
            can_close = bool(previous and not previous.isspace()) and not (
                following and following.isdigit()
            )
            if opener is not None and can_close:
                issues.append(
                    _issue(
                        text,
                        "bare-dollar-math",
                        "bare '$...$' math is disabled; use \\(...\\)",
                        line_offset + opener,
                    )
                )
                opener = None
                continue

            can_open = bool(following and not following.isspace())
            if can_open:
                opener = position

        line_offset += len(line)
    return issues


def check_text(text: str) -> list[SourceIssue]:
    """Return all hygiene issues in one Markdown source string."""

    masks = build_source_masks(text)
    issues: list[SourceIssue] = []
    issues.extend(_check_em_dashes(text, masks))
    issues.extend(_check_controls_and_dropped_tex(text, masks.rendered))
    issues.extend(_check_lone_equals(text, masks.rendered))
    # Front-matter summaries and shortcode captions also reach readers, so the
    # register pass uses the broader style view rather than rendered body text.
    issues.extend(_check_evidentiary_register(text, masks.style))
    issues.extend(_check_uniform_experiment_modality(text, masks.style))
    issues.extend(_check_tex_delimiters(text, masks.rendered))
    issues.extend(_check_bare_dollars(text, masks.rendered))
    return sorted(issues, key=lambda issue: (issue.offset, issue.code))


def main() -> None:
    errors: list[str] = []
    checked = 0

    sources = [ROOT / "README.md", *CONTENT_ROOT.rglob("*.md")]
    for path in sorted(sources):
        if path.name == "AGENTS.md":
            continue
        checked += 1
        text = path.read_text(encoding="utf-8")
        relative = project_path(path)
        for issue in check_text(text):
            errors.append(f"{relative}:{issue.line}: {issue.message}")

    if errors:
        for error in errors:
            print(f"teaching source error: {error}", file=sys.stderr)
        raise SystemExit(1)

    print(
        f"Teaching source hygiene complete: {checked} Markdown files, "
        "context-aware Markdown and TeX checks passed"
    )


if __name__ == "__main__":
    main()
