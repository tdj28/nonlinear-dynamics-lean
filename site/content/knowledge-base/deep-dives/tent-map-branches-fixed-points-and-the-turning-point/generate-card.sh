#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
src="$here/tent-map-branches-fixed-points-and-the-turning-point-card.svg"
out="$here/tent-map-branches-fixed-points-and-the-turning-point-card.png"
tmp="$(mktemp "${TMPDIR:-/tmp}/tent-deep-dive-card.XXXXXX.png")"
trap 'rm -f "$tmp"' EXIT
rsvg-convert -w 1200 -h 630 "$src" -o "$tmp"
if [[ "${1:-}" == "--verify" && -f "$out" ]]; then
  cmp "$tmp" "$out"
else
  mv "$tmp" "$out"
fi
