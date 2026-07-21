#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
output="${1:-$script_dir/random-matrix-laws-card.png}"

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,534 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 21 \
  -annotate +70+91 'DEVELOPMENT NOTEBOOK / PROBABILITY LAWS' \
  -fill '#16243A' -font Palatino-Roman -pointsize 64 \
  -annotate +68+177 'From random matrices' \
  -annotate +68+249 'to laws' \
  -fill '#4D5B6B' -font Helvetica -pointsize 23 \
  -annotate +72+308 'Push probability through a measurable map' \
  -fill '#284E72' -stroke '#284E72' -strokewidth 2 \
  -draw 'roundrectangle 72,355 222,466 14,14' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 25 \
  -annotate +113+402 'mu' \
  -font Helvetica -pointsize 17 -annotate +103+438 'on OMEGA' \
  -stroke '#A67C52' -strokewidth 4 -fill '#A67C52' \
  -draw 'line 234,411 275,411 polygon 275,411 260,399 260,423' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 286,355 456,466 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica -pointsize 25 \
  -annotate +363+401 'X' \
  -font Helvetica -pointsize 17 -annotate +313+438 'MEASURABLE' \
  -stroke '#A67C52' -strokewidth 4 -fill '#A67C52' \
  -draw 'line 468,411 509,411 polygon 509,411 494,399 494,423' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 520,355 690,466 14,14' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 24 \
  -annotate +579+401 'LAW' \
  -font Helvetica -pointsize 17 -annotate +544+438 'map X mu' \
  -fill '#284E72' -stroke none \
  -draw 'roundrectangle 746,69 1129,502 28,28' \
  -fill '#FFFDF8' \
  -draw 'roundrectangle 773,96 1102,475 18,18' \
  -fill '#C16F2C' -font Helvetica -pointsize 19 \
  -annotate +837+139 'UNITARY TEST' \
  -fill '#DCE8EE' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 807,174 905,272 12,12' \
  -draw 'line 856,174 856,272 line 807,223 905,223' \
  -stroke '#C16F2C' -strokewidth 4 -fill '#C16F2C' \
  -draw 'line 920,223 973,223 polygon 973,223 956,211 956,235' \
  -fill '#F0DBC3' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 987,174 1070,272 12,12' \
  -draw 'line 1028,174 1028,272 line 987,223 1070,223' \
  -fill '#16243A' -stroke none -font Palatino-Roman -pointsize 24 \
  -annotate +845+302 'H' \
  -fill '#934F1F' -font Palatino-Roman -pointsize 22 \
  -annotate +998+302 'U H U*' \
  -fill '#16243A' -font Helvetica -pointsize 15 \
  -annotate +831+329 'different realization, perhaps' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
  -draw 'roundrectangle 818,345 1057,411 16,16' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 25 \
  -annotate +865+385 'SAME LAW?' \
  -fill '#4D5B6B' -font Helvetica -pointsize 17 \
  -annotate +842+446 '(C_U)* nu = nu' \
  -fill '#FFFDF8' -font Helvetica -pointsize 17 \
  -annotate +70+581 'PREIMAGES  /  COMPOSITION  /  HERMITICITY  /  INVARIANCE IN LAW' \
  -strip -define png:exclude-chunk=date,time \
  "$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}
