#!/usr/bin/env python3
"""Require every substantive Lean module to have a substantial notebook page."""

from __future__ import annotations

import json
import re
import struct
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
LEAN_ROOT = ROOT / "formalization" / "NonlinearDynamics"
COVERAGE_PATH = ROOT / "site" / "data" / "lean_notebook_coverage.json"

DECLARATION = re.compile(
    r"^\s*(?:@\[[^\]]+\]\s*)*"
    r"(?:(?:noncomputable|protected)\s+)*"
    r"(?:abbrev|def|structure|class|instance|theorem|lemma)\b",
    re.MULTILINE,
)
NAMED_DECLARATION = re.compile(
    r"^\s*(?:@\[[^\]]+\]\s*)*"
    r"(?:(?:noncomputable|protected)\s+)*"
    r"(?:(?:abbrev|def|structure|class|theorem|lemma)\s+"
    r"([A-Za-z_][A-Za-z0-9_'.]*)|instance\s+([A-Za-z_][A-Za-z0-9_'.]*)\s)",
    re.MULTILINE,
)
FRONT_MATTER_END = re.compile(r"\A---\s*\n.*?\n---\s*\n", re.DOTALL)
PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"


def module_name(path: Path) -> str:
    relative = path.relative_to(ROOT / "formalization").with_suffix("")
    return ".".join(relative.parts)


def project_path(path: Path) -> str:
    return path.relative_to(ROOT).as_posix()


def fail(messages: list[str]) -> None:
    for message in messages:
        print(f"coverage error: {message}", file=sys.stderr)
    raise SystemExit(1)


def declaration_names(source: str) -> list[str]:
    """Return public, explicitly named declarations that prose must discuss."""
    return [next(name for name in match.groups() if name) for match in NAMED_DECLARATION.finditer(source)]


def png_dimensions(path: Path) -> tuple[int, int] | None:
    """Read PNG dimensions from the IHDR header without an image dependency."""
    with path.open("rb") as image:
        header = image.read(24)
    if len(header) != 24 or header[:8] != PNG_SIGNATURE or header[12:16] != b"IHDR":
        return None
    return struct.unpack(">II", header[16:24])


def main() -> None:
    if not COVERAGE_PATH.is_file():
        fail([f"missing coverage manifest: {project_path(COVERAGE_PATH)}"])

    coverage = json.loads(COVERAGE_PATH.read_text(encoding="utf-8"))
    if not isinstance(coverage, dict):
        fail(["coverage manifest must be a JSON object keyed by Lean source path"])

    substantive: dict[str, Path] = {}
    for path in sorted(LEAN_ROOT.rglob("*.lean")):
        source = path.read_text(encoding="utf-8")
        if DECLARATION.search(source):
            substantive[project_path(path)] = path

    errors: list[str] = []
    missing = sorted(set(substantive) - set(coverage))
    stale = sorted(set(coverage) - set(substantive))
    errors.extend(f"substantive Lean module has no notebook mapping: {path}" for path in missing)
    errors.extend(f"manifest entry is stale or not substantive: {path}" for path in stale)

    for lean_path, record in sorted(coverage.items()):
        if lean_path not in substantive:
            continue
        if not isinstance(record, dict):
            errors.append(f"mapping for {lean_path} must be an object")
            continue

        expected_module = module_name(substantive[lean_path])
        declared_module = record.get("module")
        if declared_module != expected_module:
            errors.append(
                f"{lean_path} names module {declared_module!r}; expected {expected_module!r}"
            )

        notebook_value = record.get("notebook")
        if not isinstance(notebook_value, str):
            errors.append(f"{lean_path} has no string-valued notebook path")
            continue

        notebook = ROOT / notebook_value
        if not notebook.is_file():
            errors.append(f"mapped notebook does not exist for {lean_path}: {notebook_value}")
            continue

        article = notebook.read_text(encoding="utf-8")
        if f'lean_module: "{expected_module}"' not in article:
            errors.append(
                f"{notebook_value} does not declare lean_module {expected_module!r}"
            )
        if not re.search(r"^draft:\s*true\s*$", article, re.MULTILINE):
            errors.append(f"new notebook coverage page is not safely draft-scoped: {notebook_value}")
        if not re.search(r"^pro_reviewed:\s*false\s*$", article, re.MULTILINE):
            errors.append(f"notebook is not marked as pending Pro review: {notebook_value}")
        if f'lean_source: "{lean_path}"' not in article:
            errors.append(f"{notebook_value} does not point to exact Lean source {lean_path!r}")
        if not re.search(r"^##\s+References\s*$", article, re.MULTILINE | re.IGNORECASE):
            errors.append(f"notebook has no References section: {notebook_value}")
        if "lake" not in article:
            errors.append(f"notebook does not show how to run its Lean module: {notebook_value}")
        if "**Editorial status.**" not in article:
            errors.append(f"notebook does not expose its editorial status: {notebook_value}")

        og_match = re.search(r'^og_image:\s*"([^"\n]+)"\s*$', article, re.MULTILINE)
        alt_match = re.search(r'^og_image_alt:\s*"([^"\n]+)"\s*$', article, re.MULTILINE)
        if not og_match:
            errors.append(f"notebook has no page-bundle social image: {notebook_value}")
        else:
            image_path = notebook.parent / og_match.group(1)
            if not image_path.is_file():
                errors.append(f"notebook social image does not exist: {project_path(image_path)}")
            elif png_dimensions(image_path) != (1200, 630):
                errors.append(
                    f"notebook social image must be a 1200x630 PNG: {project_path(image_path)}"
                )
        if not alt_match or len(alt_match.group(1).strip()) < 20:
            errors.append(f"notebook social image needs substantial alt text: {notebook_value}")

        lean_source = substantive[lean_path].read_text(encoding="utf-8")
        missing_declarations = []
        for name in declaration_names(lean_source):
            short_name = name.rsplit(".", 1)[-1]
            if name not in article and short_name not in article:
                missing_declarations.append(name)
        if missing_declarations:
            errors.append(
                f"notebook omits named declarations from {lean_path}: "
                + ", ".join(missing_declarations)
            )

        body = FRONT_MATTER_END.sub("", article, count=1)
        word_count = len(re.findall(r"\b[\w'-]+\b", body))
        if word_count < 1200:
            errors.append(
                f"notebook is too short for comprehensive coverage ({word_count} words): {notebook_value}"
            )

    if errors:
        fail(errors)

    print(
        f"Lean/notebook coverage complete: {len(substantive)} substantive modules, "
        f"{len(coverage)} comprehensive draft pages"
    )


if __name__ == "__main__":
    main()
