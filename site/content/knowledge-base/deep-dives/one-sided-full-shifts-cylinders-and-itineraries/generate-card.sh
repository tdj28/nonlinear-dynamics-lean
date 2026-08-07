#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"; src="$here/one-sided-full-shifts-cylinders-and-itineraries-card.svg"; out="$here/one-sided-full-shifts-cylinders-and-itineraries-card.png"; tmp="$(mktemp "${TMPDIR:-/tmp}/symbolic-deep-card.XXXXXX.png")"; trap 'rm -f "$tmp"' EXIT
rsvg-convert -w 1200 -h 630 "$src" -o "$tmp"; if [[ "${1:-}" == "--verify" && -f "$out" ]]; then cmp "$tmp" "$out"; else mv "$tmp" "$out"; fi
