#!/usr/bin/env python3
"""Build Hugo into temporary directories and check local links and assets.

Hugo validates relref/refterm targets, but ordinary Markdown links, fragment
anchors, and image paths can still point to missing output. Check both the
publication graph under a repository subpath and the draft graph at the root.
No external URLs are fetched and no output is written to public/.
"""

from __future__ import annotations

import argparse
from html.parser import HTMLParser
from pathlib import Path
import subprocess
import tempfile
from urllib.parse import unquote, urljoin, urlsplit


ROOT = Path(__file__).resolve().parents[1]


class RenderedPage(HTMLParser):
    def __init__(self, source: str):
        super().__init__(convert_charrefs=True)
        self.ids: set[str] = set()
        self.links: list[str] = []
        self.bridge_math: list[str] = []
        self._paper_parts: list[str] | None = None
        self.feed(source)

    def handle_starttag(self, tag: str, pairs: list[tuple[str, str | None]]) -> None:
        attrs = dict(pairs)
        if tag == "article" and "lean-bridge-paper" in (attrs.get("class") or "").split():
            self._paper_parts = []
        if attrs.get("id"):
            self.ids.add(attrs["id"])
        if tag == "a" and attrs.get("name"):
            self.ids.add(attrs["name"])
        for attribute in ("href", "src", "poster"):
            if attrs.get(attribute):
                self.links.append(attrs[attribute])
        if tag == "meta" and (
            attrs.get("property") == "og:image"
            or attrs.get("name") == "twitter:image"
        ) and attrs.get("content"):
            self.links.append(attrs["content"])

    handle_startendtag = handle_starttag

    def handle_data(self, data: str) -> None:
        if self._paper_parts is not None:
            self._paper_parts.append(data)

    def handle_endtag(self, tag: str) -> None:
        if tag == "article" and self._paper_parts is not None:
            self.bridge_math.append("".join(self._paper_parts))
            self._paper_parts = None


def audit_output(output: Path, base_url: str) -> tuple[list[str], int, int]:
    """Return errors, HTML page count, and checked local reference count."""
    output = output.resolve()
    base = urlsplit(base_url)
    prefix = unquote(base.path).rstrip("/") + "/"
    pages = {
        path: RenderedPage(path.read_text(encoding="utf-8"))
        for path in sorted(output.rglob("*.html"))
    }
    errors: set[str] = set()
    references = 0
    for path, page in pages.items():
        relative = path.relative_to(output).as_posix()
        for math in page.bridge_math:
            if any(delimiter in math for delimiter in (r"\\(", r"\\)", r"\\]")):
                errors.add(f"{relative}: double-escaped TeX delimiter in Lean bridge")
        page_route = relative[:-len("index.html")] if path.name == "index.html" else relative
        page_url = urljoin(base_url, page_route)
        for link in page.links:
            target_url = urlsplit(urljoin(page_url, link))
            if target_url.scheme not in ("http", "https"):
                continue
            if target_url.netloc != base.netloc:
                continue
            references += 1
            target_path = unquote(target_url.path)
            if not target_path.startswith(prefix):
                errors.add(f"{relative}: local URL escapes base path: {link}")
                continue
            target = (output / target_path.removeprefix(prefix)).resolve()
            if not target.is_relative_to(output):
                errors.add(f"{relative}: local URL escapes output: {link}")
                continue
            if target.is_dir():
                target /= "index.html"
            if not target.is_file():
                errors.add(f"{relative}: missing local target: {link}")
                continue
            fragment = unquote(target_url.fragment)
            # Text fragments are resolved by the browser, not by HTML IDs.
            fragment = fragment.split(":~:text=", 1)[0]
            if fragment and target in pages and fragment not in pages[target].ids:
                errors.add(f"{relative}: missing HTML fragment: {link}")
    if not pages:
        errors.add("No HTML pages found in Hugo output")
    return sorted(errors), len(pages), references


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--hugo", default="hugo", help="Hugo executable")
    args = parser.parse_args()
    scenarios = (
        ("production-subpath", "https://site-check.invalid/nonlinear-dynamics-lean/", False),
        ("draft-root", "https://site-check.invalid/", True),
    )
    failed = False
    with tempfile.TemporaryDirectory(prefix="nonlinear-rendered-site-") as directory:
        for name, base_url, drafts in scenarios:
            destination = Path(directory) / name
            command = [
                args.hugo, "--source", "site", "--config", "hugo.yaml",
                "--panicOnWarning", "--noBuildLock", "--destination", str(destination),
                "--baseURL", base_url,
            ]
            if drafts:
                command.append("--buildDrafts")
            result = subprocess.run(command, cwd=ROOT, text=True, capture_output=True)
            if result.returncode:
                print(result.stdout, end="")
                print(result.stderr, end="")
                return result.returncode
            errors, pages, references = audit_output(destination, base_url)
            print(f"Rendered site {name}: {pages} HTML pages, {references} local references, {len(errors)} errors")
            for error in errors:
                print(f"rendered-site error: {error}")
            failed = failed or bool(errors)
    return int(failed)


if __name__ == "__main__":
    raise SystemExit(main())
