#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/ordered-hermitian-spectra-and-empirical-measures-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/ordered-hermitian-spectra-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 20 \
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / RMT-10A' \
  -fill '#16243A' -font Palatino-Roman -pointsize 54 \
  -annotate +67+145 'Ordered spectra become measures' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Sort roots. Keep multiplicity. Normalize honestly. Expose the analytic gate.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 68,226 309,490 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +99+262 'HERMITIAN MATRIX' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 104,291 273,429 11,11' \
  -fill '#284E72' -stroke none -font Palatino-Roman -pointsize 27 \
  -annotate +128+339 'real spectrum' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +127+376 'unitary basis change' \
  -annotate +137+402 'preserves every root' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 320,358 354,358 polygon 365,358 350,349 350,367' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 375,226 616,490 18,18' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +405+262 'ORDERED VECTOR' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 412,291 579,429 11,11' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 16 \
  -annotate +442+327 'largest first' \
  -annotate +431+365 'ties stay repeated' \
  -annotate +434+403 'finite real index' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 627,358 661,358 polygon 672,358 657,349 657,367' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 682,226 923,490 18,18' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +705+262 'COUNTING MEASURE' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 719,291 886,429 11,11' \
  -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
  -annotate +746+327 'one point mass' \
  -annotate +751+365 'for each index' \
  -annotate +741+403 'mass is dimension' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 934,358 968,358 polygon 979,358 964,349 964,367' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 989,226 1132,490 18,18' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +1009+262 'EMPIRICAL' \
  -annotate +1009+283 'MEASURE' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 1015,311 1106,429 11,11' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 14 \
  -annotate +1028+344 'normalize' \
  -annotate +1028+375 'positive' \
  -annotate +1028+396 'dimension' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 12 \
  -annotate +1004+463 'EMPTY CASE: ZERO' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'ALGEBRA CHECKED  /  MULTIPLICITY KEPT  /  MEASURABILITY HYPOTHESIS STAYS VISIBLE' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "ordered-hermitian-spectra-and-empirical-measures-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified ordered-hermitian-spectra-and-empirical-measures-card.png"
fi
