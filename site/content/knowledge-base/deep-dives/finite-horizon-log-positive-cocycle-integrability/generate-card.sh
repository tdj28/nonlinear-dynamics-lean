#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
source_svg="$script_dir/four-cycle-positive-log-ledger.svg"
checked="$script_dir/finite-horizon-log-positive-cocycle-integrability-card.png"
rendered=""
temporary=""

cleanup() {
  test -z "$rendered" || rm -f "$rendered"
  test -z "$temporary" || rm -f "$temporary"
}
trap cleanup EXIT HUP INT TERM

generate() {
  output="$1"
  rendered="$(mktemp "/tmp/four-cycle-positive-log-ledger.XXXXXX.png")"

  # The social card is a deterministic rendering of the primary numeric
  # teaching figure. Scale uniformly and letterbox it so the complete cycle,
  # horizon ledger, and finite-integrability labels remain visible.
  rsvg-convert --format=png --width=995 --height=630 \
    --output="$rendered" "$source_svg"
  magick -size 1200x630 xc:'#F7F1E7' \
    "$rendered" -gravity center -composite \
    -alpha off -strip \
    -define png:compression-level=9 \
    "PNG:$output"
  rm -f "$rendered"
  rendered=""

  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/finite-horizon-log-positive-cocycle-integrability-card.XXXXXX.png")"
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "finite-horizon-log-positive-cocycle-integrability-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-horizon-log-positive-cocycle-integrability-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
