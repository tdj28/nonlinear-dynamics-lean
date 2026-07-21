#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/first-exact-finite-gue-trace-moments-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+92 'DEEP DIVE / FINITE GAUSSIAN UNITARY ENSEMBLE' \
    -fill '#16243A' -font Palatino-Roman -pointsize 43 \
    -annotate +72+164 'The first exact finite' \
    -annotate +72+220 'trace moments' \
    -fill '#4D5B6B' -font Helvetica -pointsize 19 \
    -annotate +76+280 'Bochner integrability, centered trace, Frobenius energy' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 722,64 1150,468 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 754,98 1118,172 12,12' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +823+129 'FINITE MATRIX LAW' \
    -font Helvetica -pointsize 14 -annotate +788+154 'ORDINARY TRACE CONVENTION' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 936,178 936,210' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
    -draw 'roundrectangle 754,214 918,316 12,12 roundrectangle 954,214 1118,316 12,12' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 15 \
    -annotate +783+246 'DIAGONAL ROUTE' \
    -annotate +979+246 'GEOMETRY ROUTE' \
    -font Helvetica -pointsize 13 \
    -annotate +778+276 'CENTERED SUM' \
    -annotate +976+276 'NORM SQUARE' \
    -annotate +786+299 'FIRST MOMENT' \
    -annotate +976+299 'SECOND MOMENT' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 836,322 836,352 line 1036,322 1036,352' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 754,356 1118,424 12,12' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 16 \
    -annotate +794+387 'EXACT INTEGRABLE EXPECTATIONS' \
    -font Helvetica -pointsize 13 -annotate +804+412 'INCLUDING THE ZERO-SIZE BRANCH' \
    -fill '#4D5B6B' -font Helvetica -pointsize 13 \
    -annotate +793+452 'NO DENSITY OR EIGENVALUE LAW IS USED' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'BOCHNER INTEGRAL  /  PUSHFORWARD  /  NORMALIZATION  /  EXACT MOMENTS' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/first-exact-finite-gue-trace-moments-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "first-exact-finite-gue-trace-moments-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified first-exact-finite-gue-trace-moments-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
