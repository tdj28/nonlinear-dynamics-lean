#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/gaussian-laws-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+104 'DEEP DIVE / RANDOM DYNAMICS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 61 \
    -annotate +72+192 'Gaussian laws,' \
    -annotate +72+258 'independence,' \
    -annotate +72+324 'and normalization' \
    -fill '#4D5B6B' -font Helvetica -pointsize 22 \
    -annotate +76+384 'From one exact law to a finite product measure' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 742,92 1080,182 16,16' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 768,211 1106,301 16,16' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 794,330 1132,420 16,16' \
    -fill '#FFF3D6' -stroke '#C16F2C' -strokewidth 4 \
    -draw 'roundrectangle 820,449 1158,515 16,16' \
    -stroke '#4D5B6B' -strokewidth 3 -fill none \
    -draw 'line 911,184 925,209 line 937,303 951,328 line 963,422 977,447' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 21 \
    -annotate +778+138 '1  scalar law: mean, variance' \
    -annotate +804+257 '2  measurable independent family' \
    -annotate +830+376 '3  joint product law' \
    -annotate +856+490 '4  normalization ledger' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'NONLINEAR DYNAMICS, FORMALLY' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/gaussian-laws-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "gaussian-laws-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified gaussian-laws-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
