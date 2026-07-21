#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-hermitian-spectra-and-empirical-measures-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+90 'DEEP DIVE / FINITE HERMITIAN SPECTRA' \
    -fill '#16243A' -font Palatino-Roman -pointsize 41 \
    -annotate +72+160 'From ordered spectra' \
    -annotate +72+214 'to empirical measures' \
    -fill '#4D5B6B' -font Helvetica -pointsize 19 \
    -annotate +76+274 'Finite algebra, zero-aware probability, measurable-law boundary' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 718,64 1152,470 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 748,98 1122,168 12,12' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +787+128 'HERMITIAN MATRIX SAMPLE' \
    -font Helvetica -pointsize 13 -annotate +798+151 'BASIS-DEPENDENT ENTRIES' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 935,174 935,200' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
    -draw 'roundrectangle 748,204 1122,274 12,12' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +779+234 'DECREASING REAL EIGENVALUES' \
    -font Helvetica -pointsize 13 -annotate +809+257 'MULTIPLICITY PRESERVED' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 935,280 935,306' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 748,310 1122,378 12,12' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 16 \
    -annotate +784+340 'ONE EMPIRICAL SPECTRAL MEASURE' \
    -font Helvetica -pointsize 13 -annotate +795+362 'EXPLICIT EMPTY-SIZE POLICY' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
    -draw 'roundrectangle 748,394 1122,438 12,12' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 14 \
    -annotate +793+422 'MEASURABILITY GATE BEFORE ITS LAW' \
    -fill '#4D5B6B' -font Helvetica -pointsize 13 \
    -annotate +791+458 'THE GATE IS AN EXPLICIT OPEN PREMISE' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'SPECTRAL THEOREM  /  GIRY SPACE  /  UNITARY INVARIANCE  /  NONCLAIMS' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/finite-hermitian-spectra-and-empirical-measures-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "finite-hermitian-spectra-and-empirical-measures-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-hermitian-spectra-and-empirical-measures-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
