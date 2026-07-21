#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-phase-averaging-for-nonpositive-subadditive-processes-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'DEEP DIVE / FINITE SUBADDITIVE ALGEBRA' \
    -fill '#16243A' -font Palatino-Roman -pointsize 39 \
    -annotate +72+160 'Finite phase averaging' \
    -annotate +72+208 'for subadditive processes' \
    -fill '#4D5B6B' -font Helvetica -pointsize 18 \
    -annotate +76+266 'Sum every residue phase. Recover one sliding finite orbit sum.' \
    -fill '#F3E8E0' -stroke '#A55445' -strokewidth 2 \
    -draw 'roundrectangle 72,334 604,408 14,14' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 15 \
    -annotate +105+378 'FINITE REINDEXING DOES NOT PROVE CONVERGENCE' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 658,54 1148,482 22,22' \
    -fill '#16243A' -stroke none -font Helvetica-Bold -pointsize 13 \
    -annotate +698+91 'RESIDUE PHASES' \
    -fill '#4D5B6B' -font Helvetica -pointsize 10 \
    -annotate +698+111 'each row samples one sparse class of starts' \
    -fill '#A67C52' -stroke none -font Helvetica-Bold -pointsize 10 \
    -annotate +698+150 'ZERO' \
    -annotate +698+202 'ONE' \
    -annotate +698+254 'TWO' \
    -annotate +698+306 'THREE' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 758,126 836,160 7,7 roundrectangle 874,126 952,160 7,7 roundrectangle 990,126 1068,160 7,7' \
    -draw 'roundrectangle 774,178 852,212 7,7 roundrectangle 890,178 968,212 7,7 roundrectangle 1006,178 1084,212 7,7' \
    -draw 'roundrectangle 790,230 868,264 7,7 roundrectangle 906,230 984,264 7,7 roundrectangle 1022,230 1100,264 7,7' \
    -draw 'roundrectangle 806,282 884,316 7,7 roundrectangle 922,282 1000,316 7,7 roundrectangle 1038,282 1116,316 7,7' \
    -fill '#A67C52' -stroke none -draw 'polygon 898,338 910,350 904,350 904,370 892,370 892,350 886,350' \
    -fill '#16243A' -font Helvetica-Bold -pointsize 11 \
    -annotate +862+391 'SUM ALL PHASES' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 714,408 1092,452 9,9' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 12 \
    -annotate +821+435 'SLIDING STARTS' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'EXACT BOUNDARIES  /  POSITIVE-TIME SIGN  /  NO ERGODIC LIMIT' \
    -strip -define png:exclude-chunk=date,time \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/finite-phase-averaging-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "finite-phase-averaging-for-nonpositive-subadditive-processes-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-phase-averaging-for-nonpositive-subadditive-processes-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
