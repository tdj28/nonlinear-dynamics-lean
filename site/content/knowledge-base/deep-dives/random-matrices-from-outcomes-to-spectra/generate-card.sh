#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
output="${1:-$script_dir/random-matrices-card.png}"

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22' \
  -fill '#16243A' -draw 'rectangle 0,535 1200,630' \
  -fill '#284E72' -draw 'roundrectangle 706,90 1128,512 24,24' \
  -fill '#FFFDF8' -draw 'roundrectangle 736,120 1098,482 16,16' \
  -fill '#DCE8EE' -stroke '#284E72' -strokewidth 2 \
  -draw 'roundrectangle 770,154 850,234 8,8 roundrectangle 866,154 946,234 8,8 roundrectangle 962,154 1042,234 8,8' \
  -fill '#F0DBC3' -stroke '#C16F2C' \
  -draw 'roundrectangle 770,250 850,330 8,8 roundrectangle 866,250 946,330 8,8 roundrectangle 962,250 1042,330 8,8' \
  -fill '#DCE8DF' -stroke '#315F55' \
  -draw 'roundrectangle 770,346 850,426 8,8 roundrectangle 866,346 946,426 8,8 roundrectangle 962,346 1042,426 8,8' \
  -stroke '#C16F2C' -strokewidth 4 -fill '#C16F2C' \
  -draw 'line 622,300 690,300 polygon 690,300 674,286 674,314' \
  -stroke none -strokewidth 0 \
  -fill '#C16F2C' -font Helvetica -pointsize 22 -annotate +72+105 'FOUNDATIONS / CHAPTER 01' \
  -fill '#16243A' -font Palatino-Roman -pointsize 74 -annotate +72+210 'Random matrices' \
  -fill '#16243A' -font Palatino-Roman -pointsize 60 -annotate +72+286 'from outcomes' \
  -fill '#C16F2C' -font Palatino-BoldItalic -pointsize 60 -annotate +72+360 'to spectra' \
  -fill '#4D5B6B' -font Helvetica -pointsize 24 -annotate +76+430 'Probability  x  linear algebra  x  Lean' \
  -fill '#16243A' -font Helvetica -pointsize 19 -annotate +76+505 'A guided ascent from coordinates to Hermitian structure' \
  -fill '#284E72' -font Helvetica -pointsize 18 \
  -annotate +799+205 'X' -annotate +893+205 'X*' -annotate +987+205 'H' \
  -fill '#934F1F' -annotate +795+301 'i,j' -annotate +890+301 'j,i' -annotate +986+301 'sum' \
  -fill '#315F55' -annotate +793+397 'law' -annotate +885+397 'sym' -annotate +982+397 'spectrum' \
  -fill '#FFFDF8' -font Helvetica -pointsize 18 -annotate +72+578 'NONLINEAR DYNAMICS, FORMALLY' \
  "$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}
