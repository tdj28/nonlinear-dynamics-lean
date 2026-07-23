#!/usr/bin/env python3
"""Reject contributor infrastructure language in public reader-facing files."""

from __future__ import annotations

from dataclasses import dataclass
import re
import sys
from pathlib import Path
from typing import Iterator


ROOT = Path(__file__).resolve().parents[1]
PUBLIC_SUFFIXES = {
    ".css",
    ".html",
    ".js",
    ".json",
    ".lean",
    ".md",
    ".sh",
    ".svg",
    ".toml",
    ".txt",
    ".yaml",
    ".yml",
}


@dataclass(frozen=True)
class ReaderLanguageIssue:
    """One internal-operations phrase found in public source."""

    label: str
    phrase: str
    line: int


FORBIDDEN_PUBLIC_PATTERNS: tuple[tuple[str, re.Pattern[str]], ...] = (
    (
        "named cloud provider",
        re.compile(r"\bRunPod\b", re.IGNORECASE),
    ),
    (
        "private-network preview route",
        re.compile(
            r"\b(?:MagicDNS|tailnet|Tailscale)\b",
            re.IGNORECASE,
        ),
    ),
    (
        "contributor-only build guard",
        re.compile(r"\bCLOUD_LEAN_BUILD\b", re.IGNORECASE),
    ),
    (
        "contributor-only Make target",
        re.compile(
            r"(?:^[ \t]*(?:\$\s+)?|`|\b(?:[Rr]un|[Uu]se|[Tt]ype|"
            r"[Ee]xecute|[Ii]nvoke|[Cc]all|[Tt]ry|[Vv]ia)\s+)"
            r"make\s+"
            r"(?:(?:"
            r"[A-Za-z_][A-Za-z0-9_]*=[^\s]+"
            r"|(?:-C|-f|-I|--directory|--file|--makefile|--include-dir)"
            r"\s+[^\s]+"
            r"|(?:-[jJlO][^\s]*|--(?:jobs|load-average|output-sync)"
            r"(?:=[^\s]+)?)(?:\s+(?!(?:check|lean|lean-file|setup|"
            r"workstation-check)\b)[^\s]+)?"
            r"|-{1,2}[^\s]+"
            r")\s+)*"
            r"(?:check|lean|lean-file|setup|workstation-check)\b",
            re.MULTILINE,
        ),
    ),
    (
        "maintainer approval gate",
        re.compile(
            r"\b(?:human[- ]approved|approved)\s+"
            r"(?:(?:Linux|cloud)(?:\s+(?:builder|compute|host|environment))?"
            r"|builder|build host|compute|environment|host)\b",
            re.IGNORECASE,
        ),
    ),
    (
        "maintainer cloud-build instruction",
        re.compile(
            r"(?<![\w-])cloud[- ](?:only|audit|backed|build|builder|checks?|commands?|"
            r"compute|environment|gates?|host|probe|project|release|validation|"
            r"worksheet|workflows?)\b|\b(?:cloud\s+approval|cloud\s+machine)\b"
            r"|\b(?:build|check|compile|run|test|validate)\b[^\n]{0,80}"
            r"\bin\s+the\s+cloud\b(?=\s*(?:[.!?,;:]|$|builder\b|"
            r"environment\b|host\b))",
            re.IGNORECASE,
        ),
    ),
    (
        "owner-machine reference",
        re.compile(
            r"\bworkstation\b|\b(?:this|the)\s+Mac(?:Book)?\b",
            re.IGNORECASE,
        ),
    ),
    (
        "maintainer build-host reference",
        re.compile(
            r"\b(?:Linux\s+(?:builder|build host|compute)"
            r"|Linux\s+release\s+gate"
            r"|build host|provisioned\s+(?:Linux|cloud|host|builder))\b",
            re.IGNORECASE,
        ),
    ),
    (
        "maintainer remote-compute reference",
        re.compile(
            r"\bremote\s+(?:build|builder|compute|host|runner)\b",
            re.IGNORECASE,
        ),
    ),
    (
        "contributor-only guarded operation",
        re.compile(
            r"\bguarded\s+(?:(?:cloud|Linux|Make|project|release)\s+)?"
            r"(?:commands?|gates?|project|release|targets?|workflows?)\b",
            re.IGNORECASE,
        ),
    ),
    (
        "internal release operation",
        re.compile(r"\binternal\s+release\s+gate\b", re.IGNORECASE),
    ),
    (
        "retained build-cache infrastructure",
        re.compile(
            r"\b(?:network\s+volume|retained\s+cache)\b",
            re.IGNORECASE,
        ),
    ),
    (
        "owner-machine prohibition",
        re.compile(
            r"\b(?:do not|don't|must not|never)\s+run\b[^\n]{0,100}"
            r"\bon\s+(?:this|the)\s+Mac(?:Book)?\b",
            re.IGNORECASE,
        ),
    ),
)


def line_number(text: str, offset: int) -> int:
    return text.count("\n", 0, offset) + 1


def check_public_text(text: str) -> list[ReaderLanguageIssue]:
    """Return contributor-infrastructure phrases in public text."""

    issues: list[ReaderLanguageIssue] = []
    for label, pattern in FORBIDDEN_PUBLIC_PATTERNS:
        for match in pattern.finditer(text):
            issues.append(
                ReaderLanguageIssue(
                    label=label,
                    phrase=match.group(),
                    line=line_number(text, match.start()),
                )
            )
    return sorted(issues, key=lambda issue: (issue.line, issue.label, issue.phrase))


def iter_public_files() -> Iterator[Path]:
    """Yield tracked-style source files that can reach readers."""

    yield ROOT / "README.md"
    yield ROOT / ".env.example"
    for public_root in (
        ROOT / "formalization" / "NonlinearDynamics",
        ROOT / "site" / "archetypes",
        ROOT / "site" / "assets",
        ROOT / "site" / "content",
        ROOT / "site" / "data",
        ROOT / "site" / "layouts",
        ROOT / "site" / "static",
    ):
        for path in sorted(public_root.rglob("*")):
            if (
                path.is_file()
                and path.suffix.lower() in PUBLIC_SUFFIXES
                and path.name != "AGENTS.md"
            ):
                yield path
    yield ROOT / "site" / "hugo.yaml"


def main() -> None:
    errors: list[str] = []
    checked = 0
    for path in iter_public_files():
        checked += 1
        text = path.read_text(encoding="utf-8")
        relative = path.relative_to(ROOT).as_posix()
        for issue in check_public_text(text):
            errors.append(
                f"{relative}:{issue.line}: {issue.label}: {issue.phrase!r}"
            )

    if errors:
        for error in errors:
            print(f"public reader-language error: {error}", file=sys.stderr)
        raise SystemExit(1)

    print(
        f"Public reader-language check complete: {checked} files contain no "
        "contributor infrastructure instructions"
    )


if __name__ == "__main__":
    main()
