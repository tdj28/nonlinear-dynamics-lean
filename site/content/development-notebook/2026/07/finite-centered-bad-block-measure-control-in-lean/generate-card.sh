#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-centered-bad-block-measure-control-in-lean-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt30-notebook-card.XXXXXX")"
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
  -annotate +68+77 'DEVELOPMENT NOTEBOOK / RMT-30' \
  -fill '#16243A' -font Palatino-Roman -pointsize 43 \
  -annotate +67+145 'Finite centered bad-block' \
  -annotate +67+197 'measure control' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+252 'Short bad witnesses become exact finite visit counts.' \
  -annotate +70+280 'Packing and integration produce a rate-ratio bound.' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 66,336 572,461 16,16' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +104+375 'FINITE MEASURE CONTROL ONLY' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +104+409 'No lower liminf. No convergence.' \
  -annotate +104+434 'No probability or ergodicity needed.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 626,62 1136,506 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 674,92 1088,157 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +770+132 'COUNT BAD-SET VISITS' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 881,163 881,190 polygon 874,183 888,183 881,194' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 674,202 1088,267 13,13' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +779+242 'CHOOSE AND PACK' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 881,273 881,300 polygon 874,293 888,293 881,304' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 674,312 1088,377 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +779+352 'INTEGRATE EXACTLY' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 881,383 881,410 polygon 874,403 888,403 881,414' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 674,422 1088,478 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +777+457 'DIVIDE BY NEGATIVE RATE' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'FINITE MASS  /  PRESERVATION  /  STRICT THRESHOLD  /  LEAN CHECKED' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "finite-centered-bad-block-measure-control-in-lean-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-centered-bad-block-measure-control-in-lean-card.png"
fi
