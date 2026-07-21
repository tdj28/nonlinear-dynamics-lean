#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-gue-coordinate-law-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+92 'DEEP DIVE / GAUSSIAN UNITARY ENSEMBLE' \
    -fill '#16243A' -font Palatino-Roman -pointsize 47 \
    -annotate +72+166 'Finite GUE from' \
    -annotate +72+225 'independent Gaussian' \
    -annotate +72+284 'coordinates' \
    -fill '#4D5B6B' -font Helvetica -pointsize 19 \
    -annotate +76+342 'Normalization, product measure, measurable pushforward' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 722,64 1150,468 22,22' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 766,98 1106,170 12,12' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 16 \
    -annotate +797+128 'DIAGONAL: N(0, 1/n)' \
    -font Helvetica -pointsize 14 -annotate +788+153 'UPPER PARTS: N(0, 1/(2n))' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 936,176 936,216' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 766,220 1106,292 12,12' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +830+252 'CANONICAL PRODUCT LAW' \
    -font Helvetica -pointsize 14 -annotate +815+277 'MARGINALS + INDEPENDENCE' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 936,298 936,338' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
    -draw 'roundrectangle 766,342 1106,414 12,12' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
    -annotate +806+374 'HERMITIAN ASSEMBLY MAP' \
    -font Helvetica -pointsize 14 -annotate +826+399 'PUSHFORWARD MATRIX LAW' \
    -fill '#4D5B6B' -font Helvetica -pointsize 13 \
    -annotate +797+447 'CHECKED LAW; LATER SYMMETRY AND SPECTRA' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 '26 DECLARATIONS  /  WIGNER SCALE  /  EXACT LAWS  /  DIRAC BOUNDARY' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/finite-gue-coordinate-law-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "finite-gue-coordinate-law-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-gue-coordinate-law-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
