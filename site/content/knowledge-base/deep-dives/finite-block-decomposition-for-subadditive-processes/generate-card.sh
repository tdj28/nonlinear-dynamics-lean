#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-block-decomposition-for-subadditive-processes-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F5F0E6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,20 rectangle 0,536 1200,630' \
    -fill '#C16F2C' -font Helvetica-Bold -pointsize 19 \
    -annotate +72+88 'DEEP DIVE / SUBADDITIVE PROCESSES' \
    -fill '#16243A' -font Palatino-Roman -pointsize 35 \
    -annotate +72+150 'Finite block decomposition' \
    -annotate +72+196 'before any limit theorem' \
    -fill '#4D5B6B' -font Helvetica -pointsize 18 \
    -annotate +76+244 'One horizon. Two correct temporal cuts.' \
    -fill '#F4E9E4' -stroke '#A34D40' -strokewidth 2 \
    -draw 'roundrectangle 72,326 596,438 16,16' \
    -fill '#963F35' -stroke none -font Helvetica-Bold -pointsize 16 \
    -annotate +96+364 'THE SHIFT IS PART OF THE BOUND' \
    -fill '#4D3B37' -font Helvetica -pointsize 16 \
    -annotate +96+397 'Correct total: 40. Wrong-shift total: 38.' \
    -annotate +96+424 'Finite algebra does not prove convergence.' \
    -fill '#FFFDF8' -stroke '#C9BBA6' -strokewidth 2 \
    -draw 'roundrectangle 650,52 1148,500 20,20' \
    -fill '#16243A' -stroke none -font Helvetica-Bold -pointsize 14 \
    -annotate +690+91 'n = 11   b = 4   q = 2   r = 3' \
    -fill '#4D5B6B' -font Helvetica -pointsize 13 \
    -annotate +690+124 'weights: 2  5  1  4  3  6  2  7  1  5  4' \
    -fill '#4D5B6B' -font Helvetica-Bold -pointsize 12 \
    -annotate +690+168 'BLOCKS FIRST: 4 + 4 + 3' \
    -fill '#F4E4CD' -stroke '#B66A2C' -strokewidth 2 \
    -draw 'roundrectangle 690,186 842,250 12,12' \
    -fill '#DFEAF2' -stroke '#416887' -strokewidth 2 \
    -draw 'roundrectangle 852,186 1004,250 12,12' \
    -fill '#E8F0E3' -stroke '#668253' -strokewidth 2 \
    -draw 'roundrectangle 1014,186 1110,250 12,12' \
    -fill '#2C2924' -stroke none -font Helvetica-Bold -pointsize 18 \
    -annotate +754+225 '12' -annotate +916+225 '18' -annotate +1048+225 '10' \
    -fill '#365B47' -font Helvetica-Bold -pointsize 14 \
    -annotate +841+278 '12 + 18 + 10 = 40' \
    -fill '#4D5B6B' -font Helvetica-Bold -pointsize 12 \
    -annotate +690+324 'REMAINDER FIRST: 3 + 4 + 4' \
    -fill '#E8F0E3' -stroke '#668253' -strokewidth 2 \
    -draw 'roundrectangle 690,342 786,406 12,12' \
    -fill '#F4E4CD' -stroke '#B66A2C' -strokewidth 2 \
    -draw 'roundrectangle 796,342 948,406 12,12' \
    -fill '#DFEAF2' -stroke '#416887' -strokewidth 2 \
    -draw 'roundrectangle 958,342 1110,406 12,12' \
    -fill '#2C2924' -stroke none -font Helvetica-Bold -pointsize 18 \
    -annotate +724+381 '8' -annotate +860+381 '15' -annotate +1022+381 '17' \
    -fill '#365B47' -font Helvetica-Bold -pointsize 14 \
    -annotate +855+434 '8 + 15 + 17 = 40' \
    -fill '#E5EEF4' -stroke '#416887' -strokewidth 2 \
    -draw 'roundrectangle 690,452 1110,480 10,10' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 12 \
    -annotate +760+472 'TWO FINITE UPPER-BOUND ORIENTATIONS' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'EXACT QUOTIENT  /  POWERED BLOCK ORBIT  /  EXPLICIT BOUNDARIES' \
    -strip -define png:exclude-chunk=date,time \
    "PNG:$output"

  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/finite-block-decomposition-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "finite-block-decomposition-for-subadditive-processes-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-block-decomposition-for-subadditive-processes-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
