#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
src="$here/empirical-raw-spacing-law-card.svg"
out="$here/empirical-raw-spacing-law-card.png"
tmp="$(mktemp "${TMPDIR:-/tmp}/empirical-raw-spacing-law-card.XXXXXX.png")"
trap 'rm -f "$tmp"' EXIT
rsvg-convert -w 1200 -h 630 "$src" -o "$tmp"
if [[ "${1:-}" == "--verify" && -f "$out" ]]; then
  cmp "$tmp" "$out"
else
  mv "$tmp" "$out"
fi
