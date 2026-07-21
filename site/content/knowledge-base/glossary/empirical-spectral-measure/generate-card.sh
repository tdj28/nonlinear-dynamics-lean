#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/empirical-spectral-measure-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'KNOWLEDGE BASE / FINITE SPECTRA' \
    -fill '#16243A' -font Palatino-Roman -pointsize 47 \
    -annotate +72+180 'Empirical' \
    -annotate +72+242 'spectral measure' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+306 'Count multiplicity, then share the mass' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 718,64 1152,470 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 752,98 1118,174 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +804+130 'ORDERED REAL SPECTRUM' \
    -font Helvetica -pointsize 14 -annotate +805+154 'ONE SLOT PER EIGENVALUE' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 935,180 935,214' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 752,218 1118,304 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
    -annotate +816+251 'COUNT EVERY INDEX SLOT' \
    -font Helvetica -pointsize 14 -annotate +809+279 'REPETITIONS ADD THEIR MASS' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 935,310 935,344' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 752,348 1118,420 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 16 \
    -annotate +805+380 'EQUAL WEIGHT IN POSITIVE SIZE' \
    -font Helvetica -pointsize 13 -annotate +811+405 'ZERO MEASURE FOR EMPTY SIZE' \
    -fill '#4D5B6B' -font Helvetica -pointsize 13 \
    -annotate +793+451 'A SAMPLE MEASURE IS NOT YET ITS LAW' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'EIGENVALUES  /  DIRAC MASSES  /  MULTIPLICITY  /  ZERO BOUNDARY' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/empirical-spectral-measure-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "empirical-spectral-measure-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified empirical-spectral-measure-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
