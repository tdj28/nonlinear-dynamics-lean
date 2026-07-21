#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/complex-gaussian-coordinates-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+104 'DEEP DIVE / RANDOM DYNAMICS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 56 \
    -annotate +72+180 'Complex Gaussian' \
    -annotate +72+244 'coordinates' \
    -annotate +72+308 'and geometry' \
    -fill '#4D5B6B' -font Helvetica -pointsize 22 \
    -annotate +76+368 'Exact laws, degeneracy, properness, and scale' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 744,76 1138,480 18,18' \
    -stroke '#A89B8C' -strokewidth 2 -fill none \
    -draw 'line 930,100 930,199 line 790,150 1070,150 line 930,220 930,319 line 790,270 1070,270 line 930,340 930,454 line 790,398 1070,398' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 4 \
    -draw 'ellipse 838,148 36,36 0,360' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 4 \
    -draw 'ellipse 1029,150 61,24 0,360' \
    -fill none -stroke '#A67C52' -strokewidth 8 \
    -draw 'line 838,229 838,311' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 4 \
    -draw 'circle 1024,270 1035,270' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 18 \
    -annotate +792+207 'EQUAL' \
    -annotate +979+207 'UNEQUAL' \
    -annotate +798+333 'ONE ZERO' \
    -annotate +974+333 'TWO ZERO' \
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
  temporary="$(mktemp "/tmp/complex-gaussian-coordinates-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "complex-gaussian-coordinates-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified complex-gaussian-coordinates-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
