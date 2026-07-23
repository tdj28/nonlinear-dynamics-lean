#!/bin/sh
set -eu

# Resolve beside this script so regeneration is independent of the caller's
# working directory.
script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/ergodic-birkhoff-limits-and-normalized-space-averages-card.png"
temporary=""

cleanup() {
  test -z "$temporary" || rm -f "$temporary"
}
trap cleanup EXIT HUP INT TERM

generate() {
  output="$1"

  magick -size 1200x630 xc:'#F7F2E8' \
    -fill '#16243A' -stroke none \
    -draw 'rectangle 0,0 1200,18 rectangle 0,560 1200,630' \
    -fill '#A66A45' -font Helvetica-Bold -pointsize 16 \
    -annotate +54+55 'KNOWLEDGE BASE / DEEP DIVE' \
    -fill '#16243A' -font Palatino-Roman -pointsize 42 \
    -annotate +52+108 'Ergodic Birkhoff limits' \
    -fill '#46576B' -font Helvetica -pointsize 18 \
    -annotate +55+145 'One two-state orbit, two measure scales, and the exact boundary of rigidity' \
    -fill '#FFFDF8' -stroke '#C9BBA8' -strokewidth 2 \
    -draw 'roundrectangle 54,181 406,536 18,18 roundrectangle 424,181 776,536 18,18 roundrectangle 794,181 1146,536 18,18' \
    -fill '#E8F0F7' -stroke none \
    -draw 'roundrectangle 72,199 388,242 12,12' \
    -fill '#284E72' -font Helvetica-Bold -pointsize 15 \
    -annotate +126+226 'THE ORBIT LEDGER' \
    -fill '#F3E8E0' -stroke '#A66A45' -strokewidth 2 \
    -draw 'circle 132,322 132,282 circle 328,322 328,282' \
    -fill none -stroke '#A66A45' -strokewidth 3 \
    -draw 'line 176,303 284,303 polygon 276,296 276,310 288,303 line 284,341 176,341 polygon 184,334 184,348 172,341' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 31 \
    -annotate +122+333 '3' \
    -annotate +318+333 '7' \
    -fill '#5A544C' -font Helvetica -pointsize 14 \
    -annotate +93+374 'left, mass 1/2' \
    -annotate +285+374 'right, mass 1/2' \
    -fill '#16243A' -font Helvetica-Bold -pointsize 18 \
    -annotate +85+424 'n = 2, 4, 6: average = 5' \
    -fill '#315F55' -font Helvetica-Bold -pointsize 17 \
    -annotate +100+469 'both starts converge to 5' \
    -fill '#5A544C' -font Helvetica -pointsize 13 \
    -annotate +89+505 'odd-horizon error shrinks to zero' \
    -fill '#F3E8E0' -stroke none \
    -draw 'roundrectangle 442,199 758,242 12,12' \
    -fill '#8B3E33' -font Helvetica-Bold -pointsize 15 \
    -annotate +485+226 'NORMALIZE THE MASS' \
    -fill '#E8F0F7' -stroke '#6C87A4' -strokewidth 1 \
    -draw 'roundrectangle 452,266 748,357 12,12' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 14 \
    -annotate +471+291 'PROBABILITY SCALE' \
    -fill '#16243A' -font Helvetica-Bold -pointsize 19 \
    -annotate +471+325 'mass 1   integral 5' \
    -fill '#315F55' -font Helvetica-Bold -pointsize 17 \
    -annotate +471+348 'target = 5' \
    -fill '#F3E8E0' -stroke '#A66A45' -strokewidth 1 \
    -draw 'roundrectangle 452,379 748,491 12,12' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 14 \
    -annotate +471+404 'MASS-TWO SCALE' \
    -fill '#16243A' -font Helvetica-Bold -pointsize 19 \
    -annotate +471+439 'mass 2   integral 10' \
    -fill '#315F55' -font Helvetica-Bold -pointsize 18 \
    -annotate +471+473 '10 / 2 = 5' \
    -fill '#EAF1E5' -stroke none \
    -draw 'roundrectangle 812,199 1128,242 12,12' \
    -fill '#315F55' -font Helvetica-Bold -pointsize 15 \
    -annotate +911+226 'BOUNDARIES' \
    -fill '#16243A' -font Helvetica-Bold -pointsize 15 \
    -annotate +824+282 'ERGODIC, NOT MIXING' \
    -fill '#8B3E33' -font Helvetica-Bold -pointsize 17 \
    -annotate +824+314 'overlap: 1/2, 0, 1/2, 0, ...' \
    -fill '#D9D0C3' -draw 'rectangle 824,336 1116,338 rectangle 824,416 1116,418' \
    -fill '#16243A' -font Helvetica-Bold -pointsize 15 \
    -annotate +824+371 'IDENTITY IS NOT ERGODIC' \
    -fill '#284E72' -font Helvetica-Bold -pointsize 17 \
    -annotate +824+402 'separate limits: 3 and 7' \
    -fill '#16243A' -font Helvetica-Bold -pointsize 15 \
    -annotate +824+452 'ZERO MASS CANNOT CANCEL' \
    -fill '#8B3E33' -font Helvetica-Bold -pointsize 17 \
    -annotate +824+484 '0 / 0 totalizes to 0' \
    -fill '#5A544C' -font Helvetica -pointsize 13 \
    -annotate +824+510 'a value is not an identification proof' \
    -fill '#FFFDF8' -font Helvetica-Bold -pointsize 16 \
    -annotate +77+601 'SAME ORBIT LIMIT  /  DIFFERENT RAW INTEGRALS  /  NORMALIZATION IS THE BRIDGE' \
    -strip -define png:exclude-chunk=date,time \
    "PNG:$output"

  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 1; then
  echo "usage: $0 [OUTPUT.png|--verify]" >&2
  exit 2
fi

if test "$#" -eq 1 && test "$1" = "--verify"; then
  temporary="$(mktemp /tmp/ergodic-birkhoff-normalized-card.XXXXXX.png)"
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "ergodic-birkhoff-limits-and-normalized-space-averages-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified ergodic-birkhoff-limits-and-normalized-space-averages-card.png"
  exit 0
fi

if test "$#" -eq 1; then
  generate "$1"
else
  generate "$checked"
fi
