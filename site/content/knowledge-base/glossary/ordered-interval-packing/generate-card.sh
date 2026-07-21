#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/ordered-interval-packing-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/ordered-interval-packing-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 20 \
  -annotate +68+76 'KNOWLEDGE BASE / GLOSSARY' \
  -fill '#16243A' -font Palatino-Roman -pointsize 54 \
  -annotate +67+145 'Ordered interval packing' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Positive lengths and nonnegative gaps encode disjoint time intervals.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,226 1132,490 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +98+264 'GAP' -annotate +259+264 'FIRST INTERVAL' -annotate +535+264 'GAP' -annotate +651+264 'SINGLETON' -annotate +844+264 'ABUTTING INTERVAL' \
  -fill '#EDE8E1' -stroke '#7F786D' -strokewidth 2 \
  -draw 'roundrectangle 96,302 205,420 10,10 roundrectangle 483,302 585,420 10,10' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 205,302 483,420 10,10' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 585,302 697,420 10,10' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 697,302 1048,420 10,10' \
  -fill none -stroke '#7F786D' -strokewidth 3 \
  -draw 'line 96,361 1104,361 line 96,349 96,373 line 1104,349 1104,373' \
  -fill '#4B6787' -stroke '#2C2924' -strokewidth 2 \
  -draw 'circle 641,361 649,361' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 14 \
  -annotate +108+454 'uncovered time' -annotate +247+454 'positive length' -annotate +508+454 'zero is allowed' -annotate +592+477 'one point' -annotate +843+454 'shared boundary, no overlap' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'ORDERED  /  HALF-OPEN  /  DISJOINT  /  FINITE HORIZON' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "ordered-interval-packing-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified ordered-interval-packing-card.png"
fi
