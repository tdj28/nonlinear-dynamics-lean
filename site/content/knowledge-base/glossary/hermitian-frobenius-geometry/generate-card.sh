#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/hermitian-frobenius-geometry-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+98 'KNOWLEDGE BASE / MATRIX GEOMETRY' \
    -fill '#16243A' -font Palatino-Roman -pointsize 49 \
    -annotate +72+184 'Hermitian Frobenius' \
    -annotate +72+246 'geometry' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+310 'The metric behind factor two and unitary symmetry' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 716,64 1154,470 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 758,102 1112,178 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +805+134 'AMBIENT FROBENIUS SPACE' \
    -font Helvetica -pointsize 14 -annotate +813+159 '||X||^2 = SUM |X_ij|^2' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 935,184 935,224' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 758,228 1112,316 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
    -annotate +805+260 'HERMITIAN REAL SUBSPACE' \
    -font Helvetica -pointsize 14 -annotate +789+288 'DIAGONAL WEIGHT 1 / PAIR WEIGHT 2' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 935,322 935,356' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 758,360 1112,424 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 16 \
    -annotate +797+399 'UNITARY CONGRUENCE = ISOMETRY' \
    -fill '#4D5B6B' -font Helvetica -pointsize 13 \
    -annotate +805+453 'ORTHONORMAL UPPER COORDINATES USE SQRT 2' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'TRACE INNER PRODUCT  /  REAL SUBSPACE  /  FACTOR TWO  /  ISOMETRY' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/hermitian-frobenius-geometry-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "hermitian-frobenius-geometry-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified hermitian-frobenius-geometry-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
