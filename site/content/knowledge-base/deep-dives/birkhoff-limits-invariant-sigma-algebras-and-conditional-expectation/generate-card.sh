#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/birkhoff-invariant-limit-deep-dive-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 20 \
  -annotate +68+78 'KNOWLEDGE BASE / DEEP DIVE' \
  -fill '#16243A' -font Palatino-Roman -pointsize 43 \
  -annotate +67+145 'Birkhoff limits and' \
  -annotate +67+198 'invariant information' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+258 'Five proof bridges connect pointwise convergence' \
  -annotate +70+286 'to invariant conditional expectation.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 66,340 580,452 16,16' \
  -fill '#16243A' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +103+373 'THE LIMIT MAY VARY BY ORBIT SECTOR' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +103+403 'No ergodicity premise collapses invariant' \
  -annotate +103+425 'information to a single global constant.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 648,62 1134,506 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 684,92 1098,156 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +793+130 'TOTAL LIMIT REPRESENTATIVE' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 891,162 891,184 polygon 884,177 898,177 891,188' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 684,196 1098,260 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +788+234 'EXACT INVARIANT MEASURABILITY' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 891,266 891,288 polygon 884,281 898,281 891,292' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 684,300 1098,364 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +791+338 'ABSOLUTE-MEAN CONVERGENCE' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 891,370 891,392 polygon 884,385 898,385 891,396' \
  -fill '#16243A' -stroke '#16243A' -strokewidth 2 \
  -draw 'roundrectangle 684,404 1098,468 13,13' \
  -fill '#FFFDF8' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +770+442 'CONDITIONAL EXPECTATION' \
  -fill '#FFFDF8' -font Helvetica -pointsize 15 \
  -annotate +68+580 'FINITE MEASURE  /  EXACT INVARIANT SIGMA ALGEBRA  /  NO ERGODICITY' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation-card.png"
fi
