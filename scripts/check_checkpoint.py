#!/usr/bin/env python3
"""Validate the living project checkpoint and its formalization inventory."""

from __future__ import annotations

import hashlib
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
ROOT_AGENTS = ROOT / "AGENTS.md"
MAKEFILE = ROOT / "Makefile"
CLOUD_GUARD = ROOT / "scripts" / "require_cloud_lean_build.sh"
CLOUD_RUNNER = ROOT / "scripts" / "run_cloud_lean_target.sh"
LAKE_MANIFEST = ROOT / "formalization" / "lake-manifest.json"
LAKE_MANIFEST_DIGEST = ROOT / "formalization" / "lake-manifest.sha256"

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

    if not ROOT_AGENTS.is_file():
        errors.append("missing repository-root AGENTS.md build-host policy")
    else:
        agents = ROOT_AGENTS.read_text(encoding="utf-8")
        for marker in ("Mathlib build host", "CLOUD_LEAN_BUILD=1"):
            if marker not in agents:
                errors.append(f"root AGENTS.md is missing build-host marker: {marker!r}")

    if not MAKEFILE.is_file():
        errors.append("missing repository Makefile")
    else:
        makefile = MAKEFILE.read_text(encoding="utf-8")
        for marker in (
            "override CLOUD_LEAN_RUNNER",
            "scripts/run_cloud_lean_target.sh",
            "workstation-check:",
        ):
            if marker not in makefile:
                errors.append(f"Makefile is missing cloud-build marker: {marker!r}")
        if "lake " in makefile:
            errors.append("Makefile invokes Lake directly instead of the guarded cloud runner")

    if not CLOUD_GUARD.is_file():
        errors.append("missing Linux/cloud Lean build guard")
    else:
        guard = CLOUD_GUARD.read_text(encoding="utf-8")
        for marker in ('host_os=$(uname -s)', '!= "Linux"', 'CLOUD_LEAN_BUILD:-0'):
            if marker not in guard:
                errors.append(f"cloud-build guard is missing marker: {marker!r}")

    if not CLOUD_RUNNER.is_file():
        errors.append("missing guarded cloud Lean target runner")
    else:
        runner = CLOUD_RUNNER.read_text(encoding="utf-8")
        guard_index = runner.find("require_cloud_lean_build.sh")
        lake_index = runner.find("lake ")
        if guard_index < 0 or lake_index < 0 or guard_index > lake_index:
            errors.append("cloud runner does not invoke its host guard before Lake")
        digest_check = "sha256sum --check lake-manifest.sha256"
        first_digest = runner.find(digest_check)
        update_index = runner.find("lake update")
        second_digest = runner.find(digest_check, first_digest + 1)
        cache_index = runner.find("lake exe cache get")
        build_branch = runner.find("  build)")
        build_digest = runner.find(digest_check, build_branch)
        build_index = runner.find("lake build", build_branch)
        file_branch = runner.find("  file)")
        file_digest = runner.find(digest_check, file_branch)
        file_index = runner.find("lake env lean -DwarningAsError=true", file_branch)
        if not (
            0 <= first_digest < update_index < second_digest < cache_index
            and 0 <= build_branch < build_digest < build_index
            and 0 <= file_branch < file_digest < file_index
            and runner.count(digest_check) == 4
        ):
            errors.append("cloud setup/build/leaf paths do not enforce manifest digest checks")
        if "realpath --canonicalize-existing" not in runner:
            errors.append("cloud leaf runner does not enforce canonical source containment")

    if not LAKE_MANIFEST.is_file() or not LAKE_MANIFEST_DIGEST.is_file():
        errors.append("missing pinned Lake manifest or its SHA-256 ledger")
    else:
        digest_fields = LAKE_MANIFEST_DIGEST.read_text(encoding="utf-8").split()
        expected_digest = digest_fields[0] if digest_fields else ""
        recorded_name = digest_fields[-1] if len(digest_fields) >= 2 else ""
        actual_digest = hashlib.sha256(LAKE_MANIFEST.read_bytes()).hexdigest()
        if expected_digest != actual_digest or recorded_name != "lake-manifest.json":
            errors.append("lake-manifest.sha256 does not match lake-manifest.json")

    if errors:
        fail(errors)

    print("Checkpoint complete: living state, roadmap, validation, and skill are synchronized")


if __name__ == "__main__":
    main()
