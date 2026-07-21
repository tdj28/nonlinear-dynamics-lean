#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/orbit-majorant-centering-for-subadditive-cocycles-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/orbit-majorant-centering-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / SUBADDITIVE COCYCLES' \
  -fill '#16243A' -font Palatino-Roman -pointsize 45 \
  -annotate +67+145 'Subtract the orbit majorant' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'One finite subtraction exposes three assumption-separated proof lanes.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 68,234 333,466 17,17' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +116+270 'FINITE PROCESS VALUE' \
  -fill '#FFFDF8' -stroke '#4B6787' -strokewidth 1.3 \
  -draw 'roundrectangle 94,310 307,366 9,9' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +145+343 'LONG HORIZON' \
  -fill '#5A544C' -font Helvetica -pointsize 12 \
  -annotate +110+414 'SHIFTED-SUBADDITIVE INPUT' \
  -fill '#16243A' -font Helvetica-Bold -pointsize 28 \
  -annotate +356+356 'MINUS' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 468,234 797,466 17,17' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +516+270 'ONE-STEP ORBIT BUDGET' \
  -fill '#FFFDF8' -stroke '#A67C52' -strokewidth 1.3 \
  -draw 'roundrectangle 494,310 771,366 9,9' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +541+343 'FINITE BIRKHOFF SUM' \
  -fill '#5A544C' -font Helvetica -pointsize 12 \
  -annotate +528+414 'POINTWISE ADDITIVE MAJORANT' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 815,350 855,350 polygon 848,341 863,350 848,359' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 879,234 1132,466 17,17' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +931+270 'CENTERED RESIDUAL' \
  -fill '#FFFDF8' -stroke '#6F8D5E' -strokewidth 1.3 \
  -draw 'roundrectangle 905,310 1106,366 9,9' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +934+343 'NONPOSITIVE AT' \
  -annotate +943+360 'POSITIVE TIME' \
  -fill '#5A544C' -font Helvetica -pointsize 12 \
  -annotate +920+414 'SUBADDITIVITY PRESERVED' \
  -fill '#FFFDF8' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +119+576 'POINTWISE COMPENSATION / NOT EXPECTATION CENTERING / NO MEAN-ZERO OR LIMIT THEOREM' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "orbit-majorant-centering-for-subadditive-cocycles-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified orbit-majorant-centering-for-subadditive-cocycles-card.png"
fi
