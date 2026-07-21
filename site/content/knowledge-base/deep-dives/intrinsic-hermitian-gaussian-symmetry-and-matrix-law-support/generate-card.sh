#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/intrinsic-hermitian-gaussian-symmetry-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+92 'DEEP DIVE / HERMITIAN GAUSSIAN GEOMETRY' \
    -fill '#16243A' -font Palatino-Roman -pointsize 43 \
    -annotate +72+164 'Intrinsic Gaussian symmetry' \
    -annotate +72+220 'and matrix-law support' \
    -fill '#4D5B6B' -font Helvetica -pointsize 19 \
    -annotate +76+280 'Frobenius isometries, standard Gaussian invariance, support' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 722,64 1150,468 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 764,98 1108,170 12,12' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +805+129 'FROBENIUS EUCLIDEAN SPACE' \
    -font Helvetica -pointsize 14 -annotate +804+153 'HERMITIAN REAL SUBSPACE' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 936,176 936,214' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 764,218 1108,286 12,12' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 16 \
    -annotate +805+249 'UNITARY REAL ISOMETRY' \
    -font Helvetica -pointsize 14 -annotate +802+273 'STANDARD GAUSSIAN INVARIANT' \
    -fill none -stroke '#8A837A' -strokewidth 3 \
    -draw 'line 936,292 936,330' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
    -draw 'roundrectangle 764,334 1108,402 12,12' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
    -annotate +795+365 'MATRIX LAW: HERMITIAN A.E.' \
    -font Helvetica -pointsize 14 -annotate +790+389 'RMT-08 BRIDGE STILL SEPARATE' \
    -fill '#4D5B6B' -font Helvetica -pointsize 13 \
    -annotate +795+445 'SUPPORT + INTRINSIC SYMMETRY, NO DENSITY CLAIM' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'TRACE GEOMETRY  /  FACTOR TWO  /  ISOMETRY  /  STANDARD GAUSSIAN' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/intrinsic-hermitian-gaussian-symmetry-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "intrinsic-hermitian-gaussian-symmetry-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified intrinsic-hermitian-gaussian-symmetry-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
