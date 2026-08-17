#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
src="$here/raw-adjacent-level-spacings-counting-measures-and-normalization-card.svg"
out="$here/raw-adjacent-level-spacings-counting-measures-and-normalization-card.png"
tmp="$(mktemp "${TMPDIR:-/tmp}/raw-spacing-dive-card.XXXXXX.png")"
trap 'rm -f "$tmp"' EXIT
rsvg-convert -w 1200 -h 630 "$src" -o "$tmp"
if [[ "${1:-}" == "--verify" && -f "$out" ]]; then
  cmp "$tmp" "$out"
else
  mv "$tmp" "$out"
fi
