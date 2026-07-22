#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/koopman-coboundary-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/koopman-coboundary-glossary-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 56 \
  -annotate +67+148 'Koopman coboundary' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+190 'One-step potential differences collapse to two orbit endpoints.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,228 1132,502 18,18' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 96,278 334,420 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +136+316 'INITIAL ENDPOINT' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +139+354 'appears with a minus sign' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 15 \
  -annotate +201+392 'REMAINS' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 348,349 404,349 polygon 404,349 386,338 386,360' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 418,258 782,440 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +513+298 'INTERIOR VALUES' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +475+337 'each appears with both signs' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 500,361 700,403 line 500,403 700,361' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +524+425 'CANCEL IN PAIRS' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 796,349 852,349 polygon 852,349 834,338 834,360' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 866,278 1104,420 14,14' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +906+316 'FINAL ENDPOINT' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +905+354 'appears with a plus sign' \
  -fill '#47633B' -font Helvetica-Bold -pointsize 15 \
  -annotate +967+392 'REMAINS' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +96+480 'HORIZON ZERO IS AN EXACT BUT VACUOUS EMPTY-SUM CASE' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'FORWARD DIFFERENCE  /  EXACT ENDPOINT TELESCOPE  /  BOUNDED POTENTIAL LIMIT' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "koopman-coboundary-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified koopman-coboundary-card.png"
fi
