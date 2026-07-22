#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/birkhoff-convergence-event-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/birkhoff-convergence-event-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 52 \
  -annotate +67+145 'Birkhoff convergence event' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Name the points where finite orbit averages settle. Do not assume they do.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,226 760,498 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +96+264 'ONE STARTING POINT, ONE SEQUENCE' \
  -fill none -stroke '#7F786D' -strokewidth 2 \
  -draw 'line 112,444 710,444 line 112,296 112,444' \
  -fill none -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'line 112,357 710,357' \
  -fill none -stroke '#4B6787' -strokewidth 4 \
  -draw 'polyline 124,416 202,321 280,382 358,342 436,368 514,350 592,360 690,356' \
  -fill '#4B6787' -stroke none \
  -draw 'circle 124,416 131,416 circle 280,382 287,382 circle 436,368 443,368 circle 592,360 599,360' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +116+474 'finite horizons move right' -annotate +525+344 'finite limit' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 800,226 1132,346 16,16' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +862+266 'IN THE EVENT' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +845+304 'some finite real limit exists' -annotate +886+328 'for this point' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 800,376 1132,498 16,16' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +860+416 'NOT AN EXISTENCE' -annotate +903+441 'THEOREM' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +839+477 'the event could still be null' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'FINITE AVERAGES  /  MEASURABLE EVENT  /  NO CONVERGENCE CLAIM' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "birkhoff-convergence-event-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified birkhoff-convergence-event-card.png"
fi
