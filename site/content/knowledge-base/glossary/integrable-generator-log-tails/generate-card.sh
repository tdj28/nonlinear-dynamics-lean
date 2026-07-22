#!/bin/sh
set -eu

LC_ALL=C
export LC_ALL

script_dir="$(unset CDPATH; cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/integrable-generator-log-tails-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+98 'KNOWLEDGE BASE / RANDOM DYNAMICS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 48 \
    -annotate +72+178 'Integrable generator' \
    -annotate +72+238 'log tails' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+302 'Three gates for signed cocycle growth' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 678,58 1148,482 22,22' \
    -fill '#4D5B6B' -stroke none -font Helvetica -pointsize 14 \
    -annotate +832+91 'THREE SEPARATE GATES' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 700,112 828,286 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 15 \
    -annotate +719+163 'POINTWISE' \
    -annotate +741+190 'UNITS' \
    -fill '#4D5B6B' -font Helvetica -pointsize 12 \
    -annotate +722+236 'algebraic gate' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 849,112 977,286 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 15 \
    -annotate +876+163 'FORWARD' \
    -annotate +895+190 'TAIL' \
    -fill '#4D5B6B' -font Helvetica -pointsize 12 \
    -annotate +865+236 'expansion budget' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 998,112 1126,286 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 15 \
    -annotate +1029+163 'INVERSE' \
    -annotate +1044+190 'TAIL' \
    -fill '#4D5B6B' -font Helvetica -pointsize 12 \
    -annotate +1008+236 'contraction budget' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 764,290 764,326 line 764,326 1062,326 line 913,290 913,366 line 1062,290 1062,326 polygon 906,359 920,359 913,370' \
    -fill '#16243A' -stroke none \
    -draw 'roundrectangle 716,374 1110,458 14,14' \
    -fill '#FFFDF8' -font Helvetica -pointsize 15 \
    -annotate +784+412 'SIGNED FINITE-TIME LOG NORM' \
    -annotate +835+439 'IS INTEGRABLE' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'POINTWISE UNITS  /  TWO TAIL BUDGETS  /  FINITE-TIME SANDWICH' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/integrable-generator-log-tails-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "integrable-generator-log-tails-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified integrable-generator-log-tails-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
