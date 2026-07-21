#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/ordered-finite-matrix-products-and-growth-bounds-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/ordered-finite-products-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / FINITE MATRIX PRODUCTS' \
  -fill '#16243A' -font Palatino-Roman -pointsize 52 \
  -annotate +67+145 'Ordered products keep time visible' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Newest factors sit on the left. Vectors still experience time in order.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 68,226 382,490 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +164+263 'TIME ORDER' \
  -fill '#FFFDF8' -stroke '#4B6787' -strokewidth 1.5 \
  -draw 'roundrectangle 96,299 160,354 10,10 roundrectangle 193,299 257,354 10,10 roundrectangle 290,299 354,354 10,10' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +112+334 'A(0)' -annotate +209+334 'A(1)' -annotate +306+334 'A(2)' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 2.5 \
  -draw 'line 164,326 185,326 polygon 191,326 181,320 181,332 line 261,326 282,326 polygon 288,326 278,320 278,332' \
  -fill '#284E72' -stroke none -font Helvetica -pointsize 16 \
  -annotate +113+397 'written: A(2) A(1) A(0)' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +111+430 'first action remains A(0)' \
  -annotate +105+458 'newest factor is leftmost' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 444,226 756,490 18,18' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +533+263 'SHIFTED SPLIT' \
  -fill '#FFFDF8' -stroke '#A67C52' -strokewidth 1.5 \
  -draw 'roundrectangle 480,300 720,365 11,11 roundrectangle 480,391 720,456 11,11' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +549+328 'LATER BLOCK' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +528+351 'shifted in time, on the left' \
  -fill '#5A544C' -font Helvetica-Bold -pointsize 16 \
  -annotate +539+419 'EARLIER PREFIX' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +527+442 'acts first, stays on the right' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 818,226 1132,490 18,18' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +910+263 'GROWTH BUDGET' \
  -fill '#FFFDF8' -stroke '#6F8D5E' -strokewidth 1.5 \
  -draw 'roundrectangle 854,300 1096,456 11,11' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +901+333 'FACTOR NORMS' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +904+363 'multiply across time' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 975,373 975,386 polygon 975,397 966,382 984,382' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +902+438 'PRODUCT / POWER' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'DETERMINISTIC FINITE TIME  /  MAXIMUM-ROW-SUM OPERATOR NORM  /  NO ASYMPTOTIC EXPONENT' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "ordered-finite-matrix-products-and-growth-bounds-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified ordered-finite-matrix-products-and-growth-bounds-card.png"
fi
