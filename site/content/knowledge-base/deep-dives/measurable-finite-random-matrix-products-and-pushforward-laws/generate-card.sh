#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/measurable-finite-random-matrix-products-and-pushforward-laws-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'DEEP DIVE / RANDOM MATRIX PRODUCTS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 43 \
    -annotate +72+166 'Measurable finite' \
    -annotate +72+218 'random-matrix products' \
    -annotate +72+270 'and pushforward laws' \
    -fill '#4D5B6B' -font Helvetica -pointsize 19 \
    -annotate +76+330 'From exact prefix evidence to a bundled probability law' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 720,54 1150,482 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 754,82 1116,142 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 14 \
    -annotate +836+119 'FINITE FACTOR PREFIX' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 935,146 935,168 polygon 928,161 942,161 935,172' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 754,176 1116,236 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 14 \
    -annotate +811+213 'POINTWISE PRODUCT MAP' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 935,240 935,262 polygon 928,255 942,255 935,266' \
    -fill '#16243A' -stroke none \
    -draw 'roundrectangle 754,270 1116,330 14,14' \
    -fill '#FFFDF8' -font Helvetica -pointsize 14 \
    -annotate +796+307 'EXACT MEASURABILITY EVIDENCE' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 935,334 935,356 polygon 928,349 942,349 935,360' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 754,364 1116,424 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 14 \
    -annotate +841+401 'RAW PRODUCT LAW' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 806,438 1064,464 10,10' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 11 \
    -annotate +834+456 'MASS-ONE PROBABILITY PACKAGE' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'SAMPLE ALGEBRA  /  PREFIX MEASURABILITY  /  RAW LAW  /  MASS-ONE EVIDENCE' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/measurable-finite-random-matrix-products-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "measurable-finite-random-matrix-products-and-pushforward-laws-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified measurable-finite-random-matrix-products-and-pushforward-laws-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
