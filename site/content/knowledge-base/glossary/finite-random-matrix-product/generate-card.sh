#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-random-matrix-product-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+98 'KNOWLEDGE BASE / RANDOM DYNAMICS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 51 \
    -annotate +72+184 'Finite random-matrix' \
    -annotate +72+246 'product' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+310 'Sample first, certify the prefix, transport second' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 694,62 1148,474 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 730,94 1112,156 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 15 \
    -annotate +810+132 'FINITE FACTOR PREFIX' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 921,160 921,184 polygon 914,177 928,177 921,188' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 730,192 1112,254 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 15 \
    -annotate +788+230 'POINTWISE ORDERED PRODUCT' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 921,258 921,282 polygon 914,275 928,275 921,286' \
    -fill '#16243A' -stroke none \
    -draw 'roundrectangle 730,290 1112,352 14,14' \
    -fill '#FFFDF8' -font Helvetica -pointsize 15 \
    -annotate +790+328 'MEASURABILITY CERTIFICATE' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 921,356 921,380 polygon 914,373 928,373 921,384' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 730,388 1112,450 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 15 \
    -annotate +830+426 'PUSHFORWARD LAW' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'FINITE PREFIX  /  SAMPLE MAP  /  CERTIFICATE  /  PRODUCT LAW' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/finite-random-matrix-product-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "finite-random-matrix-product-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-random-matrix-product-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
