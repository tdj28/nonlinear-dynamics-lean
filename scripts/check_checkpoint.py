#!/usr/bin/env python3
"""Validate the living project checkpoint and its formalization inventory."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CHECKPOINT = ROOT / "checkpoint.md"
COVERAGE = ROOT / "site" / "data" / "lean_notebook_coverage.json"
SKILL = (
    ROOT
    / ".agents"
    / "skills"
    / "formalize-nonlinear-dynamics"
    / "SKILL.md"
)

REQUIRED_HEADINGS = (
    "## Verified State",
    "## Completed Lean Vertical Slices",
    "## Exact Next Milestone",
    "## Dependency-Ordered Roadmap",
    "## Decision Ledger",
    "## Open Risks and Nonclaims",
    "## Validation Snapshot",
    "## Recent Pushes",
)


def fail(messages: list[str]) -> None:
    for message in messages:
        print(f"checkpoint error: {message}", file=sys.stderr)
    raise SystemExit(1)


def main() -> None:
    errors: list[str] = []

    if not CHECKPOINT.is_file():
        fail(["missing repository-root checkpoint.md"])
    checkpoint = CHECKPOINT.read_text(encoding="utf-8")

    if not re.search(r"^Last updated: \d{4}-\d{2}-\d{2}", checkpoint, re.MULTILINE):
        errors.append("checkpoint has no ISO-formatted Last updated date")
    if not re.search(r"^Audited baseline: `main` at `[0-9a-f]{7,40}`", checkpoint, re.MULTILINE):
        errors.append("checkpoint has no audited main-branch baseline")
    if not re.search(r"^Active direction: \S", checkpoint, re.MULTILINE):
        errors.append("checkpoint has no active direction")

    for heading in REQUIRED_HEADINGS:
        if heading not in checkpoint:
            errors.append(f"checkpoint is missing required heading: {heading}")

    if "make check" not in checkpoint or "-DwarningAsError=true" not in checkpoint:
        errors.append("checkpoint does not record the strict validation commands")

    if not COVERAGE.is_file():
        errors.append("missing Lean/notebook coverage manifest")
    else:
        coverage = json.loads(COVERAGE.read_text(encoding="utf-8"))
        for lean_path, record in sorted(coverage.items()):
            module = record.get("module") if isinstance(record, dict) else None
            if not module or module not in checkpoint:
                errors.append(
                    f"checkpoint does not mention covered substantive module for {lean_path}: {module!r}"
                )

    if not SKILL.is_file():
        errors.append("missing project formalization skill")
    else:
        skill = SKILL.read_text(encoding="utf-8")
        if "TODO" in skill:
            errors.append("project formalization skill still contains TODO placeholders")
        if "checkpoint.md" not in skill or "make check" not in skill:
            errors.append("project skill does not enforce checkpoint and validation workflow")

    if errors:
        fail(errors)

    print("Checkpoint complete: living state, roadmap, validation, and skill are synchronized")


if __name__ == "__main__":
    main()
