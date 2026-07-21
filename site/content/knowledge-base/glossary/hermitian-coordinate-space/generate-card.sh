#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/hermitian-coordinate-space-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+100 'KNOWLEDGE BASE / MATRIX STRUCTURE' \
    -fill '#16243A' -font Palatino-Roman -pointsize 55 \
    -annotate +72+190 'Hermitian' \
    -annotate +72+258 'coordinate space' \
    -fill '#4D5B6B' -font Helvetica -pointsize 21 \
    -annotate +76+322 'Store the free entries once; reflect the rest' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 724,64 1148,468 22,22' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 778,112 868,202 10,10 roundrectangle 868,202 958,292 10,10 roundrectangle 958,292 1048,382 10,10' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 868,112 958,202 10,10 roundrectangle 958,112 1048,202 10,10 roundrectangle 958,202 1048,292 10,10' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
    -draw 'roundrectangle 778,202 868,292 10,10 roundrectangle 778,292 868,382 10,10 roundrectangle 868,292 958,382 10,10' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 15 \
    -annotate +798+160 'REAL' -annotate +888+250 'REAL' -annotate +978+340 'REAL' \
    -fill '#16243A' -font Helvetica -pointsize 14 \
    -annotate +883+160 'INPUT' -annotate +973+160 'INPUT' -annotate +973+250 'INPUT' \
    -fill '#934F1F' -font Helvetica -pointsize 13 \
    -annotate +793+250 'MIRROR' -annotate +793+340 'MIRROR' -annotate +883+340 'MIRROR' \
    -fill '#4D5B6B' -font Helvetica -pointsize 13 \
    -annotate +796+420 'REAL DIAGONAL  +  COMPLEX UPPER' \
    -annotate +817+443 'CONJUGATE LOWER IS DETERMINED' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'DETERMINISTIC  /  NONREDUNDANT  /  MEASURABLE  /  ZERO CASE EXPLICIT' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/hermitian-coordinate-space-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "hermitian-coordinate-space-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified hermitian-coordinate-space-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
