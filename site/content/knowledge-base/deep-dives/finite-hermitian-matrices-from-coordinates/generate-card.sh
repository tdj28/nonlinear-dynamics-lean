#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-hermitian-coordinates-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+94 'DEEP DIVE / HERMITIAN ASSEMBLY' \
    -fill '#16243A' -font Palatino-Roman -pointsize 51 \
    -annotate +72+174 'Finite Hermitian' \
    -annotate +72+236 'matrices from' \
    -annotate +72+298 'coordinates' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+358 'Direct insertion, pointwise symmetry, measurable map' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 713,64 1156,470 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 750,104 868,222 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 15 \
    -annotate +780+145 'UPPER' -font Helvetica -pointsize 13 -annotate +786+174 'COPY' -annotate +768+198 'COMPLEX INPUT' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 876,104 994,222 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 15 \
    -annotate +891+145 'DIAGONAL' -font Helvetica -pointsize 13 -annotate +906+174 'INSERT' -annotate +900+198 'REAL INPUT' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 1002,104 1120,222 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 15 \
    -annotate +1032+145 'LOWER' -font Helvetica -pointsize 13 -annotate +1023+174 'REFLECT' -annotate +1016+198 'CONJUGATE' \
    -fill none -stroke '#7F786D' -strokewidth 3 \
    -draw 'line 809,226 888,315 line 935,226 935,315 line 1061,226 982,315' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 800,318 1070,414 15,15' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 18 \
    -annotate +842+360 'HERMITIAN MATRIX' \
    -font Helvetica -pointsize 14 -annotate +830+388 'every input, including dimension zero' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'REAL DIAGONAL  /  COMPLEX UPPER  /  CONJUGATE LOWER  /  ZERO CASE' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/finite-hermitian-coordinates-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "finite-hermitian-coordinates-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-hermitian-coordinates-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
