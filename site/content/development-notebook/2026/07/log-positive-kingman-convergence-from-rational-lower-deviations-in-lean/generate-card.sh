#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/log-positive-kingman-convergence-from-rational-lower-deviations-in-lean-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt33-notebook-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 17 \
  -annotate +68+77 'DEVELOPMENT NOTEBOOK / MILESTONE 33' \
  -fill '#16243A' -font Palatino-Roman -pointsize 35 \
  -annotate +67+128 'Log-positive Kingman' \
  -annotate +67+170 'convergence from rational' \
  -annotate +67+212 'lower deviations' \
  -fill '#4D5B6B' -font Helvetica -pointsize 16 \
  -annotate +70+256 'A guarded real lower limit turns event nullity into an honest endpoint.' \
  -annotate +70+282 'The same rational cover also constructs the missing lower bound.' \
  -fill '#F4E5E2' -stroke '#8B3E33' -strokewidth 2 \
  -draw 'roundrectangle 66,323 574,468 16,16' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +100+361 'THE SEMANTIC GATE STAYS VISIBLE' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +100+397 'Event to real lower limit:' \
  -annotate +100+422 'requires an eventual lower bound.' \
  -fill '#315F55' -font Helvetica-Bold -pointsize 15 \
  -annotate +100+448 'CHECKED BY A QUADRATIC COUNTERMODEL' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 626,62 1136,506 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 674,82 1088,136 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +780+116 'TOTAL NORMALIZATION' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 881,142 881,161 polygon 874,155 888,155 881,166' \
  -fill '#F4E5E2' -stroke '#8B3E33' -strokewidth 2 \
  -draw 'roundrectangle 674,172 1088,226 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +763+206 'GUARDED LOWER LIMIT' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 881,232 881,251 polygon 874,245 888,245 881,256' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 674,262 1088,316 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +764+296 'RATIONAL NULL COVER' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 881,322 881,341 polygon 874,335 888,335 881,346' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 674,352 1088,406 13,13' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +782+386 'ADD BIRKHOFF AVERAGE' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 881,412 881,431 polygon 874,425 888,425 881,436' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 674,442 1088,486 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +790+470 'LOG-POSITIVE LIMIT' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'RATIONAL SLACK  /  REAL LIMINF  /  BIRKHOFF  /  LEAN CHECKED' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "log-positive-kingman-convergence-from-rational-lower-deviations-in-lean-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified log-positive-kingman-convergence-from-rational-lower-deviations-in-lean-card.png"
fi
