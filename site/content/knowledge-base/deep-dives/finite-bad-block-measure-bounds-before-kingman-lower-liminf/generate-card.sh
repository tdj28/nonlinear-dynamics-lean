#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-bad-block-measure-bounds-before-kingman-lower-liminf-card.png"

generate() {
  output="$1"

  magick -size 1200x630 xc:'#F7F4F0' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,20 rectangle 0,536 1200,630' \
    -fill '#A67C52' -font Helvetica-Bold -pointsize 18 \
    -annotate +70+80 'DEEP DIVE / SUBADDITIVE PROCESSES' \
    -fill '#16243A' -font Palatino-Roman -pointsize 37 \
    -annotate +69+143 'Finite bad-block bounds' \
    -annotate +69+188 'before lower liminf' \
    -fill '#4D5B6B' -font Helvetica -pointsize 17 \
    -annotate +72+238 'Two atoms make every event, visit, integral,' \
    -annotate +72+267 'sign reversal, and ratio exactly visible.' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 68,310 570,369 13,13' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
    -annotate +96+348 'm = 5      c = -3/4      δ = -1/2' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 68,391 570,468 14,14' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 21 \
    -annotate +96+430 'bad mass  1/2  ≤  2/3  ratio' \
    -fill '#4D5B6B' -font Helvetica -pointsize 14 \
    -annotate +96+454 'Negative division reverses the order.' \
    -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 2 \
    -draw 'roundrectangle 626,52 1146,500 20,20' \
    -fill '#16243A' -stroke none -font Helvetica-Bold -pointsize 15 \
    -annotate +665+91 'STRICT FIVE-LENGTH LEDGER' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 1 \
    -draw 'roundrectangle 660,112 1112,158 9,9' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 13 \
    -annotate +680+141 'n' -annotate +754+141 'amber' \
    -annotate +884+141 'c · n' -annotate +1010+141 'bad?' \
    -fill '#2C2924' -font Helvetica -pointsize 15 \
    -annotate +680+196 '1' -annotate +770+196 '0' \
    -annotate +875+196 '-3/4' -annotate +1010+196 'no' \
    -annotate +680+248 '4' -annotate +756+248 '-3' \
    -annotate +892+248 '-3' -annotate +985+248 'no: equal' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 660,271 1112,329 10,10' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
    -annotate +680+307 '5' -annotate +756+307 '-4' \
    -annotate +869+307 '-15/4' -annotate +1000+307 'YES' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
    -draw 'roundrectangle 660,353 1112,405 10,10' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 15 \
    -annotate +696+386 'bad set = {amber}       mass = 1/2' \
    -fill '#4D5B6B' -font Helvetica -pointsize 14 \
    -annotate +670+446 'H = 12 visits: amber 12, blue 0' \
    -annotate +670+475 'Integral visit count = 6; buffered integral = -8' \
    -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 16 \
    -annotate +70+578 'FINITE EVENT  /  GREEDY PACKING  /  ATOMWISE INTEGRATION  /  NO KINGMAN LIMIT' \
    -strip -define png:exclude-chunk=date,time \
    "PNG:$output"

  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/finite-bad-block-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "finite-bad-block-measure-bounds-before-kingman-lower-liminf-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-bad-block-measure-bounds-before-kingman-lower-liminf-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
