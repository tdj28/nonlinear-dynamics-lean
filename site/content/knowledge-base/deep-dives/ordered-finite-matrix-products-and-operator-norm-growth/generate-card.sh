#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/ordered-finite-matrix-products-and-operator-norm-growth-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'DEEP DIVE / MATRIX PRODUCTS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 48 \
    -annotate +72+174 'Ordered finite products' \
    -annotate +72+232 'and operator-norm' \
    -annotate +72+290 'growth' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+350 'From chronological action to finite orbit bounds' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 724,62 1154,472 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 758,92 1120,154 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 15 \
    -annotate +832+130 'CHRONOLOGICAL RECURSION' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 939,158 939,184 polygon 932,177 946,177 939,188' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 758,192 1120,254 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 15 \
    -annotate +816+230 'MULTIPLY ONE-STEP BUDGETS' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 939,258 939,284 polygon 932,277 946,277 939,288' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 758,292 1120,354 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 15 \
    -annotate +817+330 'UNIFORM GEOMETRIC ENVELOPE' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 939,358 939,384 polygon 932,377 946,377 939,388' \
    -fill '#16243A' -stroke none \
    -draw 'roundrectangle 758,392 1120,444 12,12' \
    -fill '#FFFDF8' -font Helvetica -pointsize 15 \
    -annotate +845+425 'EVERY VECTOR ORBIT' \
    -fill '#4D5B6B' -font Helvetica -pointsize 12 \
    -annotate +796+462 'EMPTY ALGEBRA / POSITIVE-DIMENSION NORMS' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'ORDER  /  SHIFTED SPLIT  /  ROW-SUM NORM  /  PRODUCT AND POWER BOUNDS' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/ordered-finite-matrix-products-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "ordered-finite-matrix-products-and-operator-norm-growth-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified ordered-finite-matrix-products-and-operator-norm-growth-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
