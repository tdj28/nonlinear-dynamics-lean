#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
output="${1:-$script_dir/gaussian-primitives-card.png}"

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,534 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 21 \
  -annotate +70+91 'DEVELOPMENT NOTEBOOK / PROBABILITY PRIMITIVES' \
  -fill '#16243A' -font Palatino-Roman -pointsize 63 \
  -annotate +68+178 'Gaussian primitives' \
  -fill '#16243A' -font Palatino-Roman -pointsize 49 \
  -annotate +70+246 'exact laws and independence' \
  -fill '#4D5B6B' -font Helvetica -pointsize 22 \
  -annotate +72+306 'Name every coordinate law, then assemble the joint law' \
  -fill '#284E72' -stroke none \
  -draw 'roundrectangle 744,68 1129,503 28,28' \
  -fill '#FFFDF8' -stroke none \
  -draw 'roundrectangle 772,96 1101,475 18,18' \
  -fill '#C16F2C' -font Helvetica -pointsize 18 \
  -annotate +837+134 'COORDINATES FIRST' \
  -fill '#DCE8EE' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 806,162 930,230 12,12 roundrectangle 806,252 930,320 12,12 roundrectangle 806,342 930,410 12,12' \
  -fill '#16243A' -stroke none -font Helvetica -pointsize 20 \
  -annotate +844+203 'X i' \
  -annotate +831+293 'exact law' \
  -annotate +825+383 'independent' \
  -stroke '#A67C52' -strokewidth 4 -fill '#A67C52' \
  -draw 'line 943,196 980,196 polygon 980,196 965,184 965,208' \
  -draw 'line 943,286 980,286 polygon 980,286 965,274 965,298' \
  -draw 'line 943,376 980,376 polygon 980,376 965,364 965,388' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 988,162 1078,410 14,14' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 18 \
  -annotate +1004+266 'JOINT' \
  -annotate +1012+304 'LAW' \
  -fill '#284E72' -stroke '#284E72' -strokewidth 2 \
  -draw 'roundrectangle 72,362 240,464 14,14' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 23 \
  -annotate +106+405 'mean m' \
  -font Helvetica -pointsize 17 -annotate +101+438 'variance v' \
  -stroke '#A67C52' -strokewidth 4 -fill '#A67C52' \
  -draw 'line 252,413 303,413 polygon 303,413 287,401 287,425' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 315,362 501,464 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica -pointsize 22 \
  -annotate +343+403 'HasLaw X' \
  -font Helvetica -pointsize 16 -annotate +342+438 'gaussianReal m v' \
  -stroke '#A67C52' -strokewidth 4 -fill '#A67C52' \
  -draw 'line 513,413 564,413 polygon 564,413 548,401 548,425' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 576,362 697,464 14,14' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 18 \
  -annotate +597+402 'moments' \
  -font Helvetica -pointsize 15 -annotate +599+436 'all finite' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 17 \
  -annotate +70+581 'EXACT LAW  /  MEASURABLE MAP  /  PRODUCT LAW  /  ZERO VARIANCE KEPT' \
  -strip -define png:exclude-chunk=date,time \
  "$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}
