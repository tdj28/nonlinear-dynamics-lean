#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/infinite-horizon-birkhoff-average-exceedance-bounds-in-lean-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/infinite-hopf-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -stroke none \
  -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 20 \
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / INFINITE WEAK MAXIMAL BOUND' \
  -fill '#16243A' -font Palatino-Roman -pointsize 50 \
  -annotate +67+145 'Let every finite horizon speak' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'An increasing union carries one uniform finite estimate to all positive times.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,226 1132,490 18,18' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 96,270 336,374 12,12' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +128+302 'FINITE EVENTS' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +122+333 'one event per horizon' \
  -annotate +122+355 'nested by inclusion' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 352,322 430,322' \
  -fill '#A67C52' -stroke none \
  -draw 'polygon 446,322 428,313 428,331' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 446,270 686,374 12,12' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +480+302 'INCREASING UNION' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +478+333 'every positive witness' \
  -annotate +478+355 'appears at a finite stage' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 702,322 780,322' \
  -fill '#A67C52' -stroke none \
  -draw 'polygon 796,322 778,313 778,331' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 796,270 1104,374 12,12' \
  -fill '#527044' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +829+302 'INFINITE EVENT BOUND' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +829+333 'finite mass for the real form' \
  -annotate +829+355 'positive threshold only to divide' \
  -fill '#284E72' -font Helvetica-Bold -pointsize 14 \
  -annotate +98+425 'EXTENDED MEASURE:' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +260+425 'continuity needs no finiteness gate' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 14 \
  -annotate +98+458 'REAL PROJECTION:' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +250+458 'a finite target gives the reusable continuity corollary' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+579 'ALL POSITIVE TIMES  /  NO POINTWISE CONVERGENCE THEOREM' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "infinite-horizon-birkhoff-average-exceedance-bounds-in-lean-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified infinite-horizon-birkhoff-average-exceedance-bounds-in-lean-card.png"
fi
