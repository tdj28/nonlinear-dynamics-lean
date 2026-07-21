#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/empirical-spectral-law-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'KNOWLEDGE BASE / RANDOM SPECTRA' \
    -fill '#16243A' -font Palatino-Roman -pointsize 50 \
    -annotate +72+185 'Empirical spectral law' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+247 'A probability law whose outcomes are measures' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 706,62 1154,472 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 746,96 1114,164 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +829+126 'RANDOM MATRIX SAMPLE' \
    -font Helvetica -pointsize 13 -annotate +823+149 'ONE MATRIX PER TRIAL' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 930,171 930,204' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 746,211 1114,279 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 16 \
    -annotate +799+241 'ONE SAMPLE SPECTRAL MEASURE' \
    -font Helvetica -pointsize 13 -annotate +816+264 'EIGENVALUES WITH MULTIPLICITY' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 930,286 930,319' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 746,326 1114,394 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
    -annotate +810+356 'PROBABILITY LAW ON MEASURES' \
    -font Helvetica -pointsize 13 -annotate +828+379 'REPEATED MATRIX SAMPLES' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
    -draw 'roundrectangle 746,410 1114,448 12,12' \
    -fill '#4D5B6B' -stroke none -font Helvetica -pointsize 13 \
    -annotate +814+434 'THE MEAN MEASURE IS ANOTHER OBJECT' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'SAMPLE  /  PUSHFORWARD LAW  /  PROBABILITY WRAPPER  /  GIRY JOIN' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/empirical-spectral-law-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "empirical-spectral-law-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified empirical-spectral-law-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
