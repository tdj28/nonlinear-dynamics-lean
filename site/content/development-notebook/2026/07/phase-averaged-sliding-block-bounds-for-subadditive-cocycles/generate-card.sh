#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/phase-averaged-sliding-block-bounds-for-subadditive-cocycles-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/phase-averaging-card.XXXXXX")"
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
  -annotate +67+145 'Average every residue phase' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Powered-map rows become one ordinary sliding Birkhoff sum.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 1.6 \
  -draw 'roundrectangle 68,224 810,292 14,14 roundrectangle 68,310 810,378 14,14 roundrectangle 68,396 810,464 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 12 \
  -annotate +88+252 'PHASE ZERO' -annotate +88+338 'MIDDLE PHASE' -annotate +88+424 'LAST PHASE' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 1.2 \
  -draw 'roundrectangle 188,238 240,278 7,7 roundrectangle 188,324 274,364 7,7 roundrectangle 188,410 308,450 7,7' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 1.2 \
  -draw 'roundrectangle 252,238 354,278 7,7 roundrectangle 366,238 468,278 7,7 roundrectangle 480,238 582,278 7,7 roundrectangle 594,238 696,278 7,7' \
  -draw 'roundrectangle 286,324 388,364 7,7 roundrectangle 400,324 502,364 7,7 roundrectangle 514,324 616,364 7,7 roundrectangle 628,324 730,364 7,7' \
  -draw 'roundrectangle 320,410 422,450 7,7 roundrectangle 434,410 536,450 7,7 roundrectangle 548,410 650,450 7,7 roundrectangle 662,410 764,450 7,7' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 11 \
  -annotate +280+263 'BLOCK' -annotate +394+263 'BLOCK' -annotate +508+263 'BLOCK' -annotate +622+263 'BLOCK' \
  -annotate +314+349 'BLOCK' -annotate +428+349 'BLOCK' -annotate +542+349 'BLOCK' -annotate +656+349 'BLOCK' \
  -annotate +348+435 'BLOCK' -annotate +462+435 'BLOCK' -annotate +576+435 'BLOCK' -annotate +690+435 'BLOCK' \
  -fill '#EDE8E1' -stroke '#7F786D' -strokewidth 1.2 \
  -draw 'roundrectangle 708,238 790,278 7,7 roundrectangle 742,324 790,364 7,7 roundrectangle 776,410 790,450 5,5' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 832,344 870,344 polygon 862,335 878,344 862,353' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 1.8 \
  -draw 'roundrectangle 892,224 1132,464 16,16' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +936+258 'ONE SLIDING ROW' \
  -fill '#FFFDF8' -stroke '#6F8D5E' -strokewidth 1.1 \
  -draw 'roundrectangle 916,292 1108,356 9,9 roundrectangle 916,374 1108,438 9,9' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +946+320 'EVERY START' -annotate +946+339 'APPEARS ONCE' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 13 \
  -annotate +944+402 'COMMON HORIZON' -annotate +944+421 'RETAINS BOTH GAPS' \
  -fill '#FFFDF8' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +153+576 'FINITE REINDEXING / POSITIVE-TIME SIGN / NO BIRKHOFF, KINGMAN, OR LYAPUNOV LIMIT THEOREM' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "phase-averaged-sliding-block-bounds-for-subadditive-cocycles-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified phase-averaged-sliding-block-bounds-for-subadditive-cocycles-card.png"
fi
