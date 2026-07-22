#!/usr/bin/env python3
"""Require every substantive Lean module to have a substantial notebook page."""

from __future__ import annotations

import hashlib
import json
import re
import struct
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
LEAN_ROOT = ROOT / "formalization" / "NonlinearDynamics"
COVERAGE_PATH = ROOT / "site" / "data" / "lean_notebook_coverage.json"
CONTENT_ROOT = ROOT / "site" / "content"

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
FRONT_MATTER_BLOCK = re.compile(
    r"\A---[ \t]*\r?\n(?P<front>.*?)\r?\n---[ \t]*(?:\r?\n|\Z)",
    re.DOTALL,
)
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


def extract_front_matter(article: str) -> str | None:
    """Return only the leading YAML front matter, never matching body examples."""
    match = FRONT_MATTER_BLOCK.match(article)
    return match.group("front") if match else None


def front_matter_scalar(
    front_matter: str | None, key: str
) -> tuple[bool, str | None, str | None]:
    """Read one top-level quoted or plain YAML scalar with explicit errors."""
    if front_matter is None:
        return False, None, None

    if re.search(
        rf"^[ \t]*[\"']{re.escape(key)}[\"'][ \t]*:",
        front_matter,
        re.MULTILINE,
    ):
        return (
            True,
            None,
            f"must declare {key} with an unquoted top-level key",
        )
    if re.search(rf"^[ \t]+{re.escape(key)}[ \t]*:", front_matter, re.MULTILINE):
        return (
            True,
            None,
            f"must declare {key} as an unindented top-level front-matter key",
        )
    if re.search(
        rf"[{{,][ \t]*[\"']?{re.escape(key)}[\"']?[ \t]*:", front_matter
    ) or re.search(
        rf"^[ \t]*[?][ \t]+[\"']?{re.escape(key)}[\"']?[ \t]*$",
        front_matter,
        re.MULTILINE,
    ):
        return (
            True,
            None,
            f"must declare {key} as a standalone top-level scalar",
        )

    matches = re.findall(
        rf"^{re.escape(key)}[ \t]*:(?P<value>[^\r\n]*)$",
        front_matter,
        re.MULTILINE,
    )
    if not matches:
        return False, None, None
    if len(matches) != 1:
        return True, None, f"declares {key} more than once"

    raw = matches[0].strip()
    if not raw:
        return True, None, f"declares {key} without a scalar value"

    if raw.startswith('"'):
        match = re.fullmatch(r'("(?:[^"\\]|\\.)*")[ \t]*(?:#.*)?', raw)
        if not match:
            return True, None, f"declares malformed double-quoted {key}"
        try:
            value = json.loads(match.group(1))
        except json.JSONDecodeError:
            return True, None, f"declares malformed double-quoted {key}"
    elif raw.startswith("'"):
        match = re.fullmatch(r"'((?:[^']|'')*)'[ \t]*(?:#.*)?", raw)
        if not match:
            return True, None, f"declares malformed single-quoted {key}"
        value = match.group(1).replace("''", "'")
    else:
        value = re.sub(r"[ \t]+#.*$", "", raw).strip()
        if not value or not re.fullmatch(r"[^\s\[\]{},]+", value):
            return True, None, f"declares non-scalar or malformed {key}"

    if not isinstance(value, str) or not value:
        return True, None, f"declares empty {key}"
    return True, value, None


def snapshot_contract_errors(
    article: str,
    article_label: str,
    formalization_root: Path,
) -> list[str]:
    """Validate an optional site-hosted Lean snapshot entirely from front matter."""
    front_matter = extract_front_matter(article)
    snapshot_present, snapshot, snapshot_error = front_matter_scalar(
        front_matter, "lean_snapshot"
    )
    sha_present, frozen_sha, sha_error = front_matter_scalar(
        front_matter, "lean_source_sha256"
    )
    module_present, lean_module, module_error = front_matter_scalar(
        front_matter, "lean_module"
    )

    errors: list[str] = []
    if snapshot_error:
        errors.append(f"{article_label} {snapshot_error}")
    if sha_error:
        errors.append(f"{article_label} {sha_error}")
    if snapshot_present != sha_present:
        errors.append(
            f"{article_label} must declare lean_snapshot and lean_source_sha256 together"
        )
    if snapshot_present or sha_present:
        if module_error:
            errors.append(f"{article_label} {module_error}")
        elif not module_present:
            errors.append(
                f"{article_label} must declare lean_module with its Lean snapshot"
            )
    if snapshot is None or frozen_sha is None:
        return errors

    if lean_module is None or not re.fullmatch(
        r"NonlinearDynamics(?:[.][A-Za-z0-9_]+)+", lean_module
    ):
        errors.append(
            f"{article_label} names invalid snapshot lean_module {lean_module!r}"
        )
        return errors

    expected_snapshot = "/lean/" + lean_module.replace(".", "/") + ".lean"
    if snapshot != expected_snapshot:
        errors.append(
            f"{article_label} names Lean snapshot {snapshot!r}; "
            f"lean_module {lean_module!r} requires {expected_snapshot!r}"
        )

    if (
        not re.fullmatch(r"/lean/NonlinearDynamics(?:/[A-Za-z0-9_.-]+)+[.]lean", snapshot)
        or "/../" in snapshot
        or "/./" in snapshot
    ):
        errors.append(
            f"{article_label} names invalid Lean snapshot path {snapshot!r}"
        )
        return errors
    if not re.fullmatch(r"[0-9a-f]{64}", frozen_sha):
        errors.append(
            f"{article_label} names invalid lean_source_sha256 {frozen_sha!r}"
        )
        return errors

    relative_source = snapshot.removeprefix("/lean/")
    mounted_root = (formalization_root / "NonlinearDynamics").resolve()
    source_path = (formalization_root / relative_source).resolve()
    try:
        source_path.relative_to(mounted_root)
    except ValueError:
        errors.append(
            f"{article_label} names Lean snapshot outside the public mount {snapshot!r}"
        )
        return errors
    if not source_path.is_file():
        errors.append(
            f"{article_label} names missing Lean snapshot source {relative_source!r}"
        )
        return errors

    actual_sha = hashlib.sha256(source_path.read_bytes()).hexdigest()
    if frozen_sha != actual_sha:
        errors.append(
            f"{article_label} freezes Lean SHA-256 {frozen_sha!r}; "
            f"current source is {actual_sha!r}"
        )
    return errors


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

    for article_path in sorted(CONTENT_ROOT.rglob("*.md")):
        article = article_path.read_text(encoding="utf-8")
        errors.extend(
            snapshot_contract_errors(
                article,
                project_path(article_path),
                ROOT / "formalization",
            )
        )

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

        front_matter = extract_front_matter(article)
        _, snapshot, snapshot_error = front_matter_scalar(front_matter, "lean_snapshot")
        if snapshot is not None and snapshot_error is None:
            expected_snapshot = "/lean/" + substantive[lean_path].relative_to(
                ROOT / "formalization"
            ).as_posix()
            if snapshot != expected_snapshot:
                errors.append(
                    f"{notebook_value} names Lean snapshot {snapshot!r}; "
                    f"expected {expected_snapshot!r}"
                )
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

        front_match = FRONT_MATTER_BLOCK.match(article)
        body = article[front_match.end():] if front_match else article
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
