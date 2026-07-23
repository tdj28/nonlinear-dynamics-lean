#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/normalized-coordinates-to-gue-invariance-card.png"
primary="$script_dir/commuting-gaussian-pushforwards.svg"
rendered=""
temporary=""

cleanup() {
  test -z "$rendered" || rm -f "$rendered"
  test -z "$temporary" || rm -f "$temporary"
}
trap cleanup EXIT HUP INT TERM

generate() {
  output="$1"
  rendered="$(mktemp "/tmp/normalized-gue-primary.XXXXXX.png")"

  # The social card is a scaled view of the chapter's primary numeric figure.
  # At 95 percent, the complete isometry panel ends above y = 610 while the
  # deliberately wrong decoder begins below the card. Keeping a single source
  # prevents the card's ledger from drifting away from the theorem-facing
  # diagram.
  rsvg-convert --width 1140 --height 855 --output "$rendered" "$primary"
  magick -size 1200x630 xc:'#F7F4F0' \
    "$rendered" -geometry +30+8 -composite \
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
  temporary="$(mktemp "/tmp/normalized-coordinates-to-gue-invariance-card.XXXXXX.png")"
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "normalized-coordinates-to-gue-invariance-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified normalized-coordinates-to-gue-invariance-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
