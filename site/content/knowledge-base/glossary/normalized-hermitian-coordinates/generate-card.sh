#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/normalized-hermitian-coordinates-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+98 'KNOWLEDGE BASE / GAUSSIAN GEOMETRY' \
    -fill '#16243A' -font Palatino-Roman -pointsize 48 \
    -annotate +72+184 'Normalized Hermitian' \
    -annotate +72+246 'coordinates' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+310 'One real ledger for entries, geometry, and probability' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 716,64 1154,470 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 758,102 1112,178 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +815+134 'HERMITIAN ENTRY LEDGER' \
    -font Helvetica -pointsize 14 -annotate +812+159 'DIAGONAL + COMPLEX UPPER' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 935,184 935,224' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 758,228 1112,316 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
    -annotate +803+260 'NORMALIZED REAL LEDGER' \
    -font Helvetica -pointsize 14 -annotate +808+288 'ONE COMMON VARIANCE SCALE' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 935,322 935,356' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 758,360 1112,424 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 16 \
    -annotate +798+399 'INTRINSIC HERMITIAN SPACE' \
    -fill '#4D5B6B' -font Helvetica -pointsize 13 \
    -annotate +801+453 'THE FACTOR-TWO CORRECTION IS BUILT IN' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'REAL INDEX  /  ORTHONORMAL DECODING  /  PRODUCT LAW  /  ISOMETRY' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/normalized-hermitian-coordinates-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "normalized-hermitian-coordinates-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified normalized-hermitian-coordinates-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
