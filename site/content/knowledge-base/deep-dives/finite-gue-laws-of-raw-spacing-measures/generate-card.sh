#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
src="$here/finite-gue-laws-of-raw-spacing-measures-card.svg"
out="$here/finite-gue-laws-of-raw-spacing-measures-card.png"
tmp="$(mktemp "${TMPDIR:-/tmp}/finite-gue-spacing-deep-card.XXXXXX.png")"
trap 'rm -f "$tmp"' EXIT
rsvg-convert -w 1200 -h 630 "$src" -o "$tmp"
if [[ "${1:-}" == "--verify" && -f "$out" ]]; then
  cmp "$tmp" "$out"
else
  mv "$tmp" "$out"
fi
