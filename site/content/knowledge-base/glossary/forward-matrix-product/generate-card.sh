#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/forward-matrix-product-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+98 'KNOWLEDGE BASE / LINEAR DYNAMICS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 54 \
    -annotate +72+190 'Forward matrix' \
    -annotate +72+254 'product' \
    -fill '#4D5B6B' -font Helvetica -pointsize 21 \
    -annotate +76+318 'Chronological action with the newest factor on the left' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 690,70 1148,470 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 728,112 1110,184 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 17 \
    -annotate +845+155 'INITIAL STATE' \
    -fill none -stroke '#A67C52' -strokewidth 4 \
    -draw 'line 919,188 919,224 polygon 912,216 926,216 919,228' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 728,232 1110,304 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 17 \
    -annotate +796+275 'EARLIEST FACTOR ACTS FIRST' \
    -fill none -stroke '#A67C52' -strokewidth 4 \
    -draw 'line 919,308 919,344 polygon 912,336 926,336 919,348' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 728,352 1110,424 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 17 \
    -annotate +796+395 'NEWEST FACTOR ACTS LAST' \
    -fill '#4D5B6B' -font Helvetica -pointsize 14 \
    -annotate +822+453 'NEWEST IS WRITTEN ON THE LEFT' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'EMPTY HORIZON  /  SHIFTED SPLIT  /  CONSTANT POWERS  /  COLUMN ACTION' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/forward-matrix-product-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "forward-matrix-product-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified forward-matrix-product-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
