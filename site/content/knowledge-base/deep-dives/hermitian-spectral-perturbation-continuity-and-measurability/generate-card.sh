#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/hermitian-spectral-perturbation-continuity-and-measurability-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+94 'DEEP DIVE / HERMITIAN SPECTRAL ANALYSIS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 45 \
    -annotate +72+170 'Spectral perturbation' \
    -annotate +72+228 'to measurable laws' \
    -fill '#4D5B6B' -font Helvetica -pointsize 19 \
    -annotate +76+288 'A finite min-max witness closes the Giry seam' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 690,62 1150,476 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 725,92 1115,158 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 15 \
    -annotate +773+122 'TOP MODES MEET BOTTOM MODES' \
    -font Helvetica -pointsize 13 -annotate +799+145 'DIMENSION GIVES A WITNESS' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 920,165 920,195' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 725,202 1115,270 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 15 \
    -annotate +786+232 'QUADRATIC FORMS SQUEEZE A LEVEL' \
    -font Helvetica -pointsize 13 -annotate +792+255 'FROBENIUS CONTROL, BOTH SIDES' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 920,277 920,307' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 725,314 1115,382 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 15 \
    -annotate +793+344 'LIPSCHITZ SPECTRUM IS MEASURABLE' \
    -font Helvetica -pointsize 13 -annotate +811+367 'FINITE SUP METRIC' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 920,389 920,415' \
    -fill '#EDE8E1' -stroke '#7F786D' -strokewidth 3 \
    -draw 'roundrectangle 725,420 1115,456 12,12' \
    -fill '#4D5B6B' -stroke none -font Helvetica -pointsize 13 \
    -annotate +813+443 'SPECTRAL PUSHFORWARDS UNLOCK' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'EIGENBASIS  /  INTERSECTION  /  WEYL  /  LIPSCHITZ  /  GIRY' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/hermitian-spectral-perturbation-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "hermitian-spectral-perturbation-continuity-and-measurability-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified hermitian-spectral-perturbation-continuity-and-measurability-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
