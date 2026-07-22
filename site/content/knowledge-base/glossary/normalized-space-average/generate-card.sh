#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/normalized-space-average-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/normalized-space-average-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 50 \
  -annotate +67+154 'Normalized space' \
  -annotate +67+214 'average' \
  -fill '#4D5B6B' -font Helvetica -pointsize 19 \
  -annotate +70+272 'The integral total divided by total mass.' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 66,336 566,444 16,16' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +104+374 'SCALE-INDEPENDENT MEAN' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +104+407 'Scale mass and integral together;' \
  -annotate +104+430 'the normalized average stays fixed.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 632,70 1136,486 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 674,108 1094,182 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +779+140 'ORIGINAL MEASURE' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +765+164 'MASS 3  /  INTEGRAL TOTAL 6' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,188 884,220 polygon 877,213 891,213 884,224' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 674,232 1094,306 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +764+264 'FIVE TIMES THE MEASURE' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +758+288 'MASS 15  /  INTEGRAL TOTAL 30' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,312 884,344 polygon 877,337 891,337 884,348' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 674,356 1094,438 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +784+389 'SAME AVERAGE' \
  -fill '#315F55' -font Helvetica-Bold -pointsize 22 \
  -annotate +875+421 '2' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+580 'FINITE POSITIVE MASS  /  SCALE INVARIANCE  /  PROBABILITY REMOVES NORMALIZATION' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "normalized-space-average-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified normalized-space-average-card.png"
fi
