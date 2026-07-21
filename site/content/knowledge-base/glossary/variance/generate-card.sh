#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/variance-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 -annotate +72+104 'GLOSSARY / PROBABILITY' \
    -fill '#16243A' -font Palatino-Roman -pointsize 82 -annotate +72+224 'Variance' \
    -fill '#4D5B6B' -font Helvetica -pointsize 25 -annotate +76+298 'Average the squared distance from the mean' \
    -stroke '#7F786D' -strokewidth 4 -draw 'line 708,258 1092,258' \
    -stroke '#4B6787' -strokewidth 7 -draw 'line 760,236 760,280 line 1040,236 1040,280' \
    -stroke '#A67C52' -strokewidth 9 -draw 'line 900,226 900,290' \
    -stroke '#4B6787' -strokewidth 3 -draw 'line 774,326 886,326 line 914,326 1026,326' \
    -stroke none -fill '#16243A' -font Helvetica -pointsize 22 \
    -annotate +728+216 '-1' -annotate +886+206 'mean 1' -annotate +1026+216 '3' \
    -fill '#284E72' -font Helvetica -pointsize 21 -annotate +778+362 'distance 2' -annotate +938+362 'distance 2' \
    -fill '#DCE8DF' -stroke '#6F8D5E' -strokewidth 3 -draw 'roundrectangle 724,396 1076,478 16,16' \
    -stroke none -fill '#315F55' -font Helvetica -pointsize 24 -annotate +789+446 'variance = 4' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 -annotate +72+578 'NONLINEAR DYNAMICS, FORMALLY' \
    -strip \
    "$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "${1:-}" = "--verify"; then
  temporary="$(mktemp "${TMPDIR:-/tmp}/variance-card.XXXXXX.png")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "variance-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified variance-card.png"
  exit 0
fi

generate "${1:-$checked}"
