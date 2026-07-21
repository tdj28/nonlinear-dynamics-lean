#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/gaussian-unitary-ensemble-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+98 'KNOWLEDGE BASE / RANDOM MATRICES' \
    -fill '#16243A' -font Palatino-Roman -pointsize 50 \
    -annotate +72+184 'Gaussian unitary' \
    -annotate +72+246 'ensemble' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+310 'Independent Gaussian coordinates, one Hermitian law' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 716,64 1154,470 22,22' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 758,104 930,214 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 16 \
    -annotate +792+145 'DIAGONAL' -font Helvetica -pointsize 14 \
    -annotate +786+176 'REAL GAUSSIAN' -annotate +810+199 'VAR 1 / n' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 942,104 1112,214 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +980+145 'UPPER' -font Helvetica -pointsize 14 \
    -annotate +961+176 'COMPLEX GAUSSIAN' -annotate +959+199 'EACH VAR 1 / (2n)' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 845,222 895,296 line 1027,222 975,296' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 806,300 1064,400 15,15' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 18 \
    -annotate +849+341 'MEASURABLE ASSEMBLY' \
    -fill '#4D5B6B' -font Helvetica -pointsize 14 \
    -annotate +853+372 'PUSHFORWARD MATRIX LAW' \
    -fill '#16243A' -font Helvetica -pointsize 13 \
    -annotate +793+438 'DIMENSION ZERO: DIRAC AT THE EMPTY MATRIX' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'WIGNER SCALE  /  EXACT MARGINALS  /  INDEPENDENCE  /  ZERO CASE' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/gaussian-unitary-ensemble-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "gaussian-unitary-ensemble-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified gaussian-unitary-ensemble-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
