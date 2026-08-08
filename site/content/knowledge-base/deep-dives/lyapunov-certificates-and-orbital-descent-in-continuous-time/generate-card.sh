#!/usr/bin/env bash
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
src="$here/lyapunov-certificates-and-orbital-descent-in-continuous-time-card.svg"
out="$here/lyapunov-certificates-and-orbital-descent-in-continuous-time-card.png"
tmp="$(mktemp "${TMPDIR:-/tmp}/ode-lyapunov-deep-dive-card.XXXXXX.png")"
trap 'rm -f "$tmp"' EXIT
rsvg-convert -w 1200 -h 630 "$src" -o "$tmp"
if [[ "${1:-}" == "--verify" && -f "$out" ]]; then
  cmp "$tmp" "$out"
else
  mv "$tmp" "$out"
fi
