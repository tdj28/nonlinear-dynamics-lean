#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
output="${1:-$script_dir/random-matrix-measurability-card.png}"

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,24 rectangle 0,536 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 22 \
  -annotate +72+102 'DEVELOPMENT NOTEBOOK / LEAN 01' \
  -fill '#16243A' -font Palatino-Roman -pointsize 72 \
  -annotate +72+205 'When randomness' \
  -annotate +72+284 'becomes a matrix' \
  -fill '#4D5B6B' -font Helvetica -pointsize 24 \
  -annotate +76+355 'Measurable in every coordinate' \
  -stroke '#C16F2C' -strokewidth 4 -fill '#C16F2C' \
  -draw 'line 590,414 688,414 polygon 688,414 670,398 670,430' \
  -stroke none -strokewidth 0 \
  -fill '#C16F2C' -draw 'circle 554,414 568,414' \
  -fill '#C16F2C' -font Helvetica -pointsize 18 -annotate +514+390 'OUTCOME' \
  -fill '#284E72' -draw 'roundrectangle 730,88 1128,492 24,24' \
  -fill '#FFFDF8' -draw 'roundrectangle 760,118 1098,462 16,16' \
  -fill '#DCE8EE' -stroke '#284E72' -strokewidth 2 \
  -draw 'roundrectangle 790,150 870,230 8,8 roundrectangle 884,150 964,230 8,8 roundrectangle 978,150 1058,230 8,8' \
  -draw 'roundrectangle 790,244 870,324 8,8 roundrectangle 884,244 964,324 8,8 roundrectangle 978,244 1058,324 8,8' \
  -draw 'roundrectangle 790,338 870,418 8,8 roundrectangle 884,338 964,418 8,8 roundrectangle 978,338 1058,418 8,8' \
  -stroke none -strokewidth 0 \
  -fill '#C16F2C' -font Helvetica -pointsize 22 \
  -annotate +813+201 'X11' -annotate +906+201 'X12' -annotate +1000+201 'X13' \
  -annotate +813+295 'X21' -annotate +906+295 'X22' -annotate +1000+295 'X23' \
  -annotate +813+389 'X31' -annotate +906+389 'X32' -annotate +1000+389 'X33' \
  -fill '#16243A' -font Helvetica -pointsize 19 \
  -annotate +76+475 'One interface for ensembles, random Jacobians, and cocycles' \
  -fill '#FFFDF8' -font Helvetica -pointsize 18 \
  -annotate +72+579 'NONLINEAR DYNAMICS, FORMALLY' \
  "$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}
