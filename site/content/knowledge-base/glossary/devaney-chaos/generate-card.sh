#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
src="$here/devaney-chaos-card.svg"; out="$here/devaney-chaos-card.png"; tmp="$(mktemp "${TMPDIR:-/tmp}/devaney-glossary-card.XXXXXX.png")"
trap 'rm -f "$tmp"' EXIT
rsvg-convert -w 1200 -h 630 "$src" -o "$tmp"
if [[ "${1:-}" == "--verify" && -f "$out" ]]; then cmp "$tmp" "$out"; else mv "$tmp" "$out"; fi
