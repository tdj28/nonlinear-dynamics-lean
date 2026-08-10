#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
src="$here/logistic-ordinary-differential-equation-card.svg"
out="$here/logistic-ordinary-differential-equation-card.png"
tmp="$(mktemp "${TMPDIR:-/tmp}/logistic-ode-glossary-card.XXXXXX.png")"
trap 'rm -f "$tmp"' EXIT
rsvg-convert -w 1200 -h 630 "$src" -o "$tmp"
if [[ "${1:-}" == "--verify" && -f "$out" ]]; then
  cmp "$tmp" "$out"
else
  mv "$tmp" "$out"
fi
