"""Regression tests for the site-hosted Lean snapshot contract."""

from __future__ import annotations

import hashlib
import tempfile
import unittest
from pathlib import Path

try:
    from scripts.check_lean_notebook_coverage import snapshot_contract_errors
except ModuleNotFoundError:
    # ``unittest discover -s scripts`` puts scripts/ itself on sys.path.
    from check_lean_notebook_coverage import snapshot_contract_errors


class LeanSnapshotContractTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temp_dir = tempfile.TemporaryDirectory()
        self.formalization_root = Path(self.temp_dir.name) / "formalization"
        self.source = (
            self.formalization_root / "NonlinearDynamics" / "Example.lean"
        )
        self.source.parent.mkdir(parents=True)
        self.source.write_text("theorem checked : True := by trivial\n", encoding="utf-8")
        self.sha = hashlib.sha256(self.source.read_bytes()).hexdigest()

    def tearDown(self) -> None:
        self.temp_dir.cleanup()

    @staticmethod
    def article(
        front_matter: str,
        body: str = "Body.\n",
        module: str | None = "NonlinearDynamics.Example",
    ) -> str:
        module_line = f"lean_module: {module}\n" if module is not None else ""
        return f"---\n{module_line}{front_matter}\n---\n{body}"

    def errors(self, article: str) -> list[str]:
        return snapshot_contract_errors(
            article,
            "site/content/example/index.md",
            self.formalization_root,
        )

    def test_accepts_quoted_pair(self) -> None:
        article = self.article(
            'lean_snapshot: "/lean/NonlinearDynamics/Example.lean"\n'
            f'lean_source_sha256: "{self.sha}"'
        )
        self.assertEqual([], self.errors(article))

    def test_accepts_unquoted_pair(self) -> None:
        article = self.article(
            "lean_snapshot: /lean/NonlinearDynamics/Example.lean\n"
            f"lean_source_sha256: {self.sha}"
        )
        self.assertEqual([], self.errors(article))

    def test_rejects_snapshot_without_hash(self) -> None:
        errors = self.errors(
            self.article('lean_snapshot: "/lean/NonlinearDynamics/Example.lean"')
        )
        self.assertTrue(any("must declare" in error for error in errors), errors)

    def test_rejects_hash_without_snapshot(self) -> None:
        errors = self.errors(
            self.article(f'lean_source_sha256: "{self.sha}"')
        )
        self.assertTrue(any("must declare" in error for error in errors), errors)

    def test_unquoted_snapshot_still_counts_as_present(self) -> None:
        errors = self.errors(
            self.article("lean_snapshot: /lean/NonlinearDynamics/Example.lean")
        )
        self.assertTrue(any("must declare" in error for error in errors), errors)

    def test_rejects_malformed_scalar(self) -> None:
        errors = self.errors(
            self.article(
                "lean_snapshot: [/lean/NonlinearDynamics/Example.lean]\n"
                f"lean_source_sha256: {self.sha}"
            )
        )
        self.assertTrue(any("malformed" in error for error in errors), errors)

    def test_ignores_body_only_examples(self) -> None:
        article = self.article(
            'title: "No snapshot"',
            "```yaml\nlean_snapshot: /lean/NonlinearDynamics/Example.lean\n"
            f"lean_source_sha256: {self.sha}\n```\n",
        )
        self.assertEqual([], self.errors(article))

    def test_rejects_stale_hash(self) -> None:
        article = self.article(
            "lean_snapshot: /lean/NonlinearDynamics/Example.lean\n"
            f"lean_source_sha256: {'0' * 64}"
        )
        errors = self.errors(article)
        self.assertTrue(any("current source" in error for error in errors), errors)

    def test_rejects_missing_source_path(self) -> None:
        article = self.article(
            "lean_snapshot: /lean/NonlinearDynamics/Missing.lean\n"
            f"lean_source_sha256: {self.sha}"
        )
        errors = self.errors(article)
        self.assertTrue(any("missing Lean snapshot" in error for error in errors), errors)

    def test_rejects_path_outside_public_lean_mount(self) -> None:
        article = self.article(
            "lean_snapshot: /private/Example.lean\n"
            f"lean_source_sha256: {self.sha}"
        )
        errors = self.errors(article)
        self.assertTrue(any("invalid Lean snapshot path" in error for error in errors), errors)

    def test_rejects_path_traversal(self) -> None:
        article = self.article(
            "lean_snapshot: /lean/NonlinearDynamics/../Example.lean\n"
            f"lean_source_sha256: {self.sha}"
        )
        errors = self.errors(article)
        self.assertTrue(any("invalid Lean snapshot path" in error for error in errors), errors)

    def test_rejects_snapshot_without_module(self) -> None:
        article = self.article(
            "lean_snapshot: /lean/NonlinearDynamics/Example.lean\n"
            f"lean_source_sha256: {self.sha}",
            module=None,
        )
        errors = self.errors(article)
        self.assertTrue(any("must declare lean_module" in error for error in errors), errors)

    def test_rejects_snapshot_for_another_module(self) -> None:
        article = self.article(
            "lean_snapshot: /lean/NonlinearDynamics/Example.lean\n"
            f"lean_source_sha256: {self.sha}",
            module="NonlinearDynamics.Other",
        )
        errors = self.errors(article)
        self.assertTrue(any("requires" in error for error in errors), errors)

    def test_rejects_symlink_escape(self) -> None:
        outside = Path(self.temp_dir.name) / "Outside.lean"
        outside.write_text("theorem outside : True := by trivial\n", encoding="utf-8")
        escape = self.source.parent / "Escape.lean"
        escape.symlink_to(outside)
        outside_sha = hashlib.sha256(outside.read_bytes()).hexdigest()
        article = self.article(
            "lean_snapshot: /lean/NonlinearDynamics/Escape.lean\n"
            f"lean_source_sha256: {outside_sha}",
            module="NonlinearDynamics.Escape",
        )
        errors = self.errors(article)
        self.assertTrue(any("outside the public mount" in error for error in errors), errors)

    def test_rejects_indented_reserved_keys(self) -> None:
        article = (
            "---\n"
            " lean_module: NonlinearDynamics.Example\n"
            " lean_snapshot: /lean/NonlinearDynamics/Example.lean\n"
            "---\nBody.\n"
        )
        errors = self.errors(article)
        self.assertTrue(any("unindented top-level" in error for error in errors), errors)

    def test_rejects_quoted_reserved_keys(self) -> None:
        article = (
            "---\n"
            '"lean_module": NonlinearDynamics.Example\n'
            '"lean_snapshot": /lean/NonlinearDynamics/Example.lean\n'
            f'"lean_source_sha256": {self.sha}\n'
            "---\nBody.\n"
        )
        errors = self.errors(article)
        self.assertTrue(any("unquoted top-level" in error for error in errors), errors)

    def test_rejects_flow_mapping_reserved_keys(self) -> None:
        article = (
            "---\n"
            "{lean_module: NonlinearDynamics.Example, "
            "lean_snapshot: /lean/NonlinearDynamics/Example.lean, "
            f"lean_source_sha256: {self.sha}}}\n"
            "---\nBody.\n"
        )
        errors = self.errors(article)
        self.assertTrue(any("standalone top-level" in error for error in errors), errors)


if __name__ == "__main__":
    unittest.main()
