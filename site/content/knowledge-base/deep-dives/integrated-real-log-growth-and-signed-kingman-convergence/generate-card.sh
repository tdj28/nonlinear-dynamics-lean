#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
src="$here/integrated-real-log-growth-and-signed-kingman-convergence-card.svg"
out="$here/integrated-real-log-growth-and-signed-kingman-convergence-card.png"
tmp="$(mktemp "${TMPDIR:-/tmp}/rmt35-dd-card.XXXXXX.png")"
trap 'rm -f "$tmp"' EXIT
rsvg-convert -w 1200 -h 630 "$src" -o "$tmp"
if [[ "${1:-}" == "--verify" && -f "$out" ]]; then
  cmp "$tmp" "$out"
else
  mv "$tmp" "$out"
fi
