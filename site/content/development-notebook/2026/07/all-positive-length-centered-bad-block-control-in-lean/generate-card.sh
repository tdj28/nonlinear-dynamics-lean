#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/all-positive-length-centered-bad-block-control-in-lean-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt31-notebook-card.XXXXXX")"
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
  -annotate +68+77 'DEVELOPMENT NOTEBOOK / MILESTONE 31' \
  -fill '#16243A' -font Palatino-Roman -pointsize 42 \
  -annotate +67+143 'All-positive-length centered' \
  -annotate +67+194 'bad-block control' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+250 'Nested finite caps exhaust every positive finite witness.' \
  -annotate +70+278 'A uniform measure ratio survives the increasing union.' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 66,336 574,463 16,16' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +101+376 'ONE FINITE WITNESS' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +101+410 'Not infinitely many witnesses.' \
  -annotate +101+437 'Raw event is not invariant.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 626,62 1136,506 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 674,92 1088,157 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +764+132 'NEST THE FINITE CAPS' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 881,163 881,190 polygon 874,183 888,183 881,194' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 674,202 1088,267 13,13' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +748+242 'TAKE EXTENDED MEASURE LIMIT' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 881,273 881,300 polygon 874,293 888,293 881,304' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 674,312 1088,377 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +771+352 'CHECK FINITE TARGET MASS' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 881,383 881,410 polygon 874,403 888,403 881,414' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 674,422 1088,478 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +754+457 'KEEP THE SAME RATIO BOUND' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'FINITE MASS  /  PRESERVATION  /  NO PROBABILITY  /  LEAN CHECKED' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "all-positive-length-centered-bad-block-control-in-lean-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified all-positive-length-centered-bad-block-control-in-lean-card.png"
fi
