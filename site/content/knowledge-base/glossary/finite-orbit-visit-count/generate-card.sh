#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-orbit-visit-count-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/finite-orbit-visit-count-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 20 \
  -annotate +68+78 'KNOWLEDGE BASE / GLOSSARY' \
  -fill '#16243A' -font Palatino-Roman -pointsize 51 \
  -annotate +67+158 'Finite orbit visit count' \
  -fill '#4D5B6B' -font Helvetica -pointsize 19 \
  -annotate +70+220 'Count membership in a chosen finite orbit prefix.' \
  -annotate +70+250 'The result is a natural number.' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 66,320 566,445 16,16' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +100+357 'SEVEN POSITIONS, THREE VISITS' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +100+392 'Indicator values add to the count 3.' \
  -annotate +100+419 'Cast to real to state the integral.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 632,70 1136,486 22,22' \
  -fill '#4D5B6B' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +671+111 'ZERO-BASED HORIZON: TIMES 0 THROUGH 6' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 672,146 722,236 8,8 roundrectangle 804,146 854,236 8,8 roundrectangle 1002,146 1052,236 8,8' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 738,146 788,236 8,8 roundrectangle 870,146 920,236 8,8 roundrectangle 936,146 986,236 8,8 roundrectangle 1068,146 1118,236 8,8' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +690+177 '0' -annotate +822+177 '2' -annotate +1020+177 '5' \
  -fill '#4D5B6B' -font Helvetica-Bold -pointsize 15 \
  -annotate +756+177 '1' -annotate +888+177 '3' -annotate +954+177 '4' -annotate +1086+177 '6' \
  -fill '#284E72' -font Helvetica-Bold -pointsize 14 \
  -annotate +690+216 '1' -annotate +822+216 '1' -annotate +1020+216 '1' \
  -fill '#4D5B6B' -font Helvetica-Bold -pointsize 14 \
  -annotate +756+216 '0' -annotate +888+216 '0' -annotate +954+216 '0' -annotate +1086+216 '0' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 895,258 895,286 polygon 887,280 903,280 895,291' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 672,306 1118,374 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +793+335 'NATURAL COUNT = 3' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +757+359 'CAST TO REAL 3 FOR THE INTEGRAL' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 672,396 1118,454 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +756+430 'FINITE COUNT, NOT LONG-RUN FREQUENCY' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+580 'ZERO-BASED HORIZON  /  NATURAL COUNT  /  INDICATOR SUM  /  EXACT FINITE INTEGRAL' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "finite-orbit-visit-count-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-orbit-visit-count-card.png"
fi
