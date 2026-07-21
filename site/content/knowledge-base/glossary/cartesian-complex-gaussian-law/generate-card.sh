#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/cartesian-complex-gaussian-law-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+104 'KNOWLEDGE BASE / PROBABILITY' \
    -fill '#16243A' -font Palatino-Roman -pointsize 60 \
    -annotate +72+202 'Cartesian complex' \
    -annotate +72+270 'Gaussian law' \
    -fill '#4D5B6B' -font Helvetica -pointsize 22 \
    -annotate +76+334 'Two exact real laws, one explicit complex coordinate' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 720,105 910,185 16,16' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 950,105 1140,185 16,16' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 815,250 1045,330 16,16' \
    -fill none -stroke '#7F786D' -strokewidth 3 \
    -draw 'line 815,188 885,247 line 1045,188 975,247 line 930,333 930,382' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 20 \
    -annotate +758+154 'REAL LAW' \
    -font Helvetica -pointsize 18 \
    -annotate +970+154 'IMAGINARY LAW' \
    -font Helvetica -pointsize 20 \
    -annotate +849+299 'PRODUCT + MAP' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 4 \
    -draw 'ellipse 930,418 34,34 0,360' \
    -fill '#A67C52' -stroke none -draw 'circle 930,418 935,418' \
    -fill '#315F55' -font Helvetica -pointsize 17 \
    -annotate +871+478 'COMPLEX LAW' \
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
  temporary="$(mktemp "/tmp/cartesian-complex-gaussian-law-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "cartesian-complex-gaussian-law-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified cartesian-complex-gaussian-law-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
