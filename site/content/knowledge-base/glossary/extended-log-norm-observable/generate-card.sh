#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/extended-log-norm-observable-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+98 'KNOWLEDGE BASE / RANDOM DYNAMICS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 47 \
    -annotate +72+176 'Extended log-norm' \
    -annotate +72+234 'observable' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+300 'Finite matrix growth without hiding zero' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 704,62 1148,474 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 740,94 1112,154 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 15 \
    -annotate +833+131 'COCYCLE MATRIX VALUE' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 926,158 926,180 polygon 919,173 933,173 926,184' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 740,190 1112,250 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 15 \
    -annotate +797+227 'LARGEST ABSOLUTE ROW SUM' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 926,254 926,276 polygon 919,269 933,269 926,280' \
    -fill '#16243A' -stroke none \
    -draw 'roundrectangle 740,286 1112,346 14,14' \
    -fill '#FFFDF8' -font Helvetica -pointsize 15 \
    -annotate +827+323 'EXTENDED LOGARITHM' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 926,350 926,372 polygon 919,365 933,365 926,376' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 740,382 1112,446 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 14 \
    -annotate +782+410 'ZERO MATRIX MAPS TO BOTTOM' \
    -annotate +797+432 'POSITIVE NORM KEEPS ITS LOG' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'ROW-SUM NORM  /  MEASURABLE  /  ZERO-AWARE  /  SUBADDITIVE' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/extended-log-norm-observable-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "extended-log-norm-observable-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified extended-log-norm-observable-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
