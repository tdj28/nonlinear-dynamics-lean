#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/from-finite-maximal-bounds-to-an-infinite-weak-estimate-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/infinite-weak-estimate-deep-card.XXXXXX")"
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
  -annotate +68+76 'KNOWLEDGE BASE / DEEP DIVE' \
  -fill '#16243A' -font Palatino-Roman -pointsize 47 \
  -annotate +67+139 'From finite maximal bounds' \
  -annotate +67+191 'to an infinite weak estimate' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+229 'Build the exact union, cross the measure limit, and divide only at a positive threshold.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,260 1132,507 18,18' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 94,300 294,424 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +137+337 'FINITE EVENTS' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +120+370 'strict positive-time witnesses' \
  -annotate +133+393 'uniform finite bounds' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 304,362 358,362 polygon 358,362 342,352 342,372' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 370,286 594,438 14,14' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +409+326 'INCREASING UNION' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +397+360 'extended measure is continuous' \
  -annotate +411+383 'with no finiteness gate' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 11 \
  -annotate +397+414 'FINITE TARGET: SAFE CONVERSION' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 604,362 658,362 polygon 658,362 642,352 642,372' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 670,300 870,424 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +711+337 'ALL THRESHOLDS' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +697+370 'finite total measure' \
  -annotate +698+393 'multiplication bound' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 880,362 920,362 polygon 920,362 904,352 904,372' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 932,286 1110,438 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +956+326 'WEAK ESTIMATE' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +954+361 'positive threshold' \
  -annotate +962+384 'licenses division' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 12 \
  -annotate +956+408 'NO POINTWISE' \
  -annotate +967+425 'CONVERGENCE' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 13 \
  -annotate +95+480 'The infinity cliff is explicit: real measure maps infinite extended mass to zero.' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'EXACT UNION  /  EXTENDED MEASURE FIRST  /  POSITIVE DIVISION' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "from-finite-maximal-bounds-to-an-infinite-weak-estimate-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified from-finite-maximal-bounds-to-an-infinite-weak-estimate-card.png"
fi
