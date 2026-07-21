#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/hermitian-spectral-perturbation-and-measurability-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/hermitian-spectrum-continuity-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / RMT-10B' \
  -fill '#16243A' -font Palatino-Roman -pointsize 51 \
  -annotate +67+145 'Stable spectra become random observables' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Build the witness. Bound every ordered level. Close the measurability gate.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 68,226 309,490 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +92+262 'HERMITIAN INPUTS' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 101,291 276,429 11,11' \
  -fill '#284E72' -stroke none -font Helvetica -pointsize 16 \
  -annotate +127+327 'two matrices' \
  -annotate +126+365 'one intrinsic' \
  -annotate +113+403 'Frobenius geometry' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 320,358 354,358 polygon 365,358 350,349 350,367' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 375,226 616,490 18,18' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +407+262 'SHARED WITNESS' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 408,291 583,429 11,11' \
  -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
  -annotate +443+327 'top of first' \
  -annotate +430+365 'bottom of second' \
  -annotate +425+403 'dimensions overlap' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 627,358 661,358 polygon 672,358 657,349 657,367' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 682,226 923,490 18,18' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +712+262 'ORDERED LEVELS' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 715,291 890,429 11,11' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 16 \
  -annotate +745+327 'each position' \
  -annotate +744+365 'moves at most' \
  -annotate +732+403 'the matrix change' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 934,358 968,358 polygon 979,358 964,349 964,367' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 989,226 1132,490 18,18' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +1004+262 'MEASURABLE' \
  -annotate +1004+283 'SPECTRAL MAPS' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 1015,311 1106,429 11,11' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 14 \
  -annotate +1028+344 'counting' \
  -annotate +1028+375 'empirical' \
  -annotate +1028+406 'law bridge' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'FROBENIUS BOUND CHECKED  /  SUP-METRIC VECTOR  /  NOT HOFFMAN-WIELANDT' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "hermitian-spectral-perturbation-and-measurability-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified hermitian-spectral-perturbation-and-measurability-card.png"
fi
