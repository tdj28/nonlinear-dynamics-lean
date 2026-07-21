#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
output="${1:-$script_dir/trace-power-card.png}"

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22' \
  -fill '#16243A' -draw 'rectangle 0,535 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 21 \
  -annotate +70+96 'DEVELOPMENT NOTEBOOK / OBSERVABLES' \
  -fill '#16243A' -font Palatino-Roman -pointsize 72 \
  -annotate +68+190 'Trace-power' \
  -fill '#16243A' -font Palatino-Roman -pointsize 72 \
  -annotate +68+273 'observables' \
  -fill '#4D5B6B' -font Helvetica -pointsize 24 \
  -annotate +72+333 'A matrix becomes a measurable scalar' \
  -fill '#284E72' -stroke '#284E72' -strokewidth 2 \
  -draw 'roundrectangle 76,376 246,474 14,14' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 26 \
  -annotate +107+434 'X(omega)' \
  -stroke '#A67C52' -strokewidth 4 -fill '#A67C52' \
  -draw 'line 258,425 315,425 polygon 315,425 299,413 299,437' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 326,376 496,474 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica -pointsize 27 \
  -annotate +367+435 'power k' \
  -stroke '#A67C52' -strokewidth 4 -fill '#A67C52' \
  -draw 'line 508,425 565,425 polygon 565,425 549,413 549,437' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 576,376 746,474 14,14' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 28 \
  -annotate +626+435 'trace' \
  -fill '#284E72' -stroke none -draw 'roundrectangle 790,76 1128,500 28,28' \
  -fill '#FFFDF8' -stroke none -draw 'roundrectangle 817,103 1101,473 18,18' \
  -fill '#DCE8EE' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 851,142 917,208 8,8' \
  -draw 'roundrectangle 931,142 997,208 8,8' \
  -draw 'roundrectangle 1011,142 1077,208 8,8' \
  -fill '#F0DBC3' -stroke '#A67C52' \
  -draw 'roundrectangle 851,222 917,288 8,8' \
  -draw 'roundrectangle 931,222 997,288 8,8' \
  -draw 'roundrectangle 1011,222 1077,288 8,8' \
  -fill '#EAF1E5' -stroke '#6F8D5E' \
  -draw 'roundrectangle 851,302 917,368 8,8' \
  -draw 'roundrectangle 931,302 997,368 8,8' \
  -draw 'roundrectangle 1011,302 1077,368 8,8' \
  -stroke '#C16F2C' -strokewidth 5 -fill none \
  -draw "path 'M 858,420 C 900,386 1024,386 1067,420'" \
  -fill '#C16F2C' -stroke none \
  -draw 'polygon 1067,420 1048,413 1058,398' \
  -fill '#16243A' -font Helvetica -pointsize 18 \
  -annotate +873+449 'real for Hermitian X' \
  -fill '#FFFDF8' -font Helvetica -pointsize 18 \
  -annotate +70+590 'MEASURABLE FIRST  /  EXPECTATION LATER  /  PROOF CHECKED IN LEAN' \
  "$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}
