#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
source_svg="$script_dir/three-cycle-centered-process-ledger.svg"
checked="$script_dir/orbit-majorant-centering-for-subadditive-processes-card.png"
rendered=""
temporary=""

cleanup() {
  test -z "$rendered" || rm -f "$rendered"
  test -z "$temporary" || rm -f "$temporary"
}
trap cleanup EXIT HUP INT TERM

generate() {
  output="$1"
  rendered="$(mktemp "/tmp/three-cycle-centered-process-ledger.XXXXXX.png")"

  # Render the primary numeric teaching figure deterministically. Uniform
  # scaling plus letterboxing keeps the complete orbit, horizon table, and
  # finite integrability ledger visible on the social card.
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
  temporary="$(mktemp "/tmp/orbit-majorant-centering-for-subadditive-processes-card.XXXXXX.png")"
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "orbit-majorant-centering-for-subadditive-processes-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified orbit-majorant-centering-for-subadditive-processes-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
