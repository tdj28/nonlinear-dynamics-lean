#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
src="$here/lorenz-three-coordinate-field-symmetry-and-equilibria-card.svg"
out="$here/lorenz-three-coordinate-field-symmetry-and-equilibria-card.png"
tmp="$(mktemp "${TMPDIR:-/tmp}/lorenz-deep-card.XXXXXX.png")"
trap 'rm -f "$tmp"' EXIT
rsvg-convert -w 1200 -h 630 "$src" -o "$tmp"
if [[ "${1:-}" == "--verify" && -f "$out" ]]; then
  cmp "$tmp" "$out"
else
  mv "$tmp" "$out"
fi
