#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-block-decomposition-for-subadditive-processes-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'DEEP DIVE / SUBADDITIVE PROCESSES' \
    -fill '#16243A' -font Palatino-Roman -pointsize 36 \
    -annotate +72+158 'Finite block decomposition' \
    -annotate +72+204 'for subadditive processes' \
    -fill '#4D5B6B' -font Helvetica -pointsize 18 \
    -annotate +76+262 'Two orientations. Exact assumptions. No limit theorem.' \
    -fill '#F3E8E0' -stroke '#A55445' -strokewidth 2 \
    -draw 'roundrectangle 72,334 590,408 14,14' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 15 \
    -annotate +114+378 'FINITE BLOCKS DO NOT PROVE CONVERGENCE' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 666,54 1148,482 22,22' \
    -fill '#16243A' -stroke none -font Helvetica-Bold -pointsize 13 \
    -annotate +702+92 'THE SAME HORIZON, TWO UPPER-BOUND ROUTES' \
    -fill '#4D5B6B' -font Helvetica-Bold -pointsize 11 \
    -annotate +702+135 'BLOCKS FIRST' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 702,154 800,210 10,10 roundrectangle 808,154 906,210 10,10 roundrectangle 914,154 1012,210 10,10' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
    -draw 'roundrectangle 1020,154 1110,210 10,10' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 10 \
    -annotate +726+187 'FULL' -annotate +832+187 'FULL' -annotate +938+187 'FULL' \
    -fill '#8B5A33' -font Helvetica-Bold -pointsize 9 \
    -annotate +1041+187 'SHORT' \
    -fill '#4D5B6B' -font Helvetica-Bold -pointsize 11 \
    -annotate +702+268 'REMAINDER FIRST' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
    -draw 'roundrectangle 702,287 792,343 10,10' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 800,287 898,343 10,10 roundrectangle 906,287 1004,343 10,10 roundrectangle 1012,287 1110,343 10,10' \
    -fill '#8B5A33' -stroke none -font Helvetica-Bold -pointsize 9 \
    -annotate +723+320 'SHORT' \
    -fill '#284E72' -font Helvetica-Bold -pointsize 10 \
    -annotate +824+320 'FULL' -annotate +930+320 'FULL' -annotate +1036+320 'FULL' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 702,382 1110,444 12,12' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 11 \
    -annotate +750+410 'FINITE UPPER BOUNDS' \
    -fill '#315F55' -font Helvetica -pointsize 10 \
    -annotate +764+429 'NO ASYMPTOTIC STEP' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'FINITE ALGEBRA  /  POWERED ORBITS  /  EXPLICIT BOUNDARIES' \
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
