#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/generator-presented-one-sided-discrete-matrix-cocycles-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'DEEP DIVE / RANDOM COCYCLES' \
    -fill '#16243A' -font Palatino-Roman -pointsize 42 \
    -annotate +72+164 'Generator-presented' \
    -annotate +72+215 'one-sided discrete' \
    -annotate +72+266 'matrix cocycles' \
    -fill '#4D5B6B' -font Helvetica -pointsize 19 \
    -annotate +76+326 'Over a measure-preserving forward base' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 716,54 1150,482 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 752,82 1114,142 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 14 \
    -annotate +827+119 'INITIAL ENVIRONMENT' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 933,146 933,168 polygon 926,161 940,161 933,172' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 752,176 1114,236 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 14 \
    -annotate +818+213 'EARLY MATRIX BLOCK' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 933,240 933,262 polygon 926,255 940,255 933,266' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 752,270 1114,330 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 14 \
    -annotate +815+307 'SHIFT ENVIRONMENT' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 933,334 933,356 polygon 926,349 940,349 933,360' \
    -fill '#16243A' -stroke none \
    -draw 'roundrectangle 752,364 1114,424 14,14' \
    -fill '#FFFDF8' -font Helvetica -pointsize 14 \
    -annotate +802+401 'LATER BLOCK ON THE LEFT' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 800,438 1066,464 10,10' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 11 \
    -annotate +820+456 'BASE ITERATES PRESERVE MEASURE' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'FORWARD ORBIT  /  GENERATOR  /  COCYCLE LAW  /  MEASURE-PRESERVING BASE' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/generator-presented-discrete-cocycles-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "generator-presented-one-sided-discrete-matrix-cocycles-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified generator-presented-one-sided-discrete-matrix-cocycles-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
