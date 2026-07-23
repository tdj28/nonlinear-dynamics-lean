#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
primary="$script_dir/two-outcome-spectral-law-ledger.svg"
checked="$script_dir/finite-gue-empirical-spectral-laws-and-normalized-moments-card.png"
rendered=""
temporary=""

cleanup() {
  test -z "$rendered" || rm -f "$rendered"
  test -z "$temporary" || rm -f "$temporary"
}
trap cleanup EXIT HUP INT TERM

generate() {
  output="$1"
  rendered="$(mktemp "/tmp/finite-gue-spectral-law-primary.XXXXXX.png")"

  # The primary teaching figure is already 1200 by 630. Render that exact
  # numeric source so the social card cannot drift from the worked example.
  rsvg-convert --width 1200 --height 630 --output "$rendered" "$primary"
  magick "$rendered" \
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
  temporary="$(mktemp "/tmp/finite-gue-empirical-spectral-laws-and-normalized-moments-card.XXXXXX.png")"
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "finite-gue-empirical-spectral-laws-and-normalized-moments-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-gue-empirical-spectral-laws-and-normalized-moments-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
