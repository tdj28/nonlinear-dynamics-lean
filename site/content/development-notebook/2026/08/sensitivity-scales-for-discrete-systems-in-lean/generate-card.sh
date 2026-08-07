#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
src="$here/sensitivity-scales-for-discrete-systems-in-lean-card.svg"
out="$here/sensitivity-scales-for-discrete-systems-in-lean-card.png"
tmp="$(mktemp "${TMPDIR:-/tmp}/det-sensitivity-note-card.XXXXXX.png")"
trap 'rm -f "$tmp"' EXIT
rsvg-convert -w 1200 -h 630 "$src" -o "$tmp"
if [[ "${1:-}" == "--verify" && -f "$out" ]]; then
  cmp "$tmp" "$out"
else
  mv "$tmp" "$out"
fi
