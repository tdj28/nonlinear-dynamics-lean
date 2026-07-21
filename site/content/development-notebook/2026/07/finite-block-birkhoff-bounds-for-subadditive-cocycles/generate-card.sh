#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-block-birkhoff-bounds-for-subadditive-cocycles-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/finite-block-birkhoff-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / SUBADDITIVE COCYCLE BLOCKS' \
  -fill '#16243A' -font Palatino-Roman -pointsize 48 \
  -annotate +67+145 'Finite blocks before limits' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'One finite block decomposition supports two independent conclusions.' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 68,234 264,474 17,17' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +111+270 'REMAINDER' \
  -fill '#FFFDF8' -stroke '#A67C52' -strokewidth 1.3 \
  -draw 'roundrectangle 92,304 240,354 9,9 roundrectangle 92,382 240,432 9,9' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +111+334 'FIRST OR LAST' \
  -fill '#5A544C' -font Helvetica -pointsize 11 \
  -annotate +101+413 'FINITE REMAINDER TERM' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 324,234 694,474 17,17' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +432+270 'POINTWISE BLOCK BOUND' \
  -fill '#FFFDF8' -stroke '#4B6787' -strokewidth 1.3 \
  -draw 'roundrectangle 352,304 666,354 9,9 roundrectangle 352,382 666,432 9,9' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +402+334 'SHIFTED SUBADDITIVITY ONLY' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +397+413 'NO PROBABILITY OR ERGODICITY' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 754,234 1132,474 17,17' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +834+270 'FINITE-SUM INTEGRABILITY' \
  -fill '#FFFDF8' -stroke '#6F8D5E' -strokewidth 1.3 \
  -draw 'roundrectangle 782,304 1104,354 9,9 roundrectangle 782,382 1104,432 9,9' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +836+334 'BLOCK OBSERVABLE INTEGRABLE' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +829+413 'BLOCK MAP PRESERVES MEASURE' \
  -fill '#FFFDF8' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +157+576 'FINITE BOUNDS ONLY: NO ALMOST-EVERYWHERE LIMIT, KINGMAN THEOREM, OR LYAPUNOV EXPONENT' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "finite-block-birkhoff-bounds-for-subadditive-cocycles-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-block-birkhoff-bounds-for-subadditive-cocycles-card.png"
fi
