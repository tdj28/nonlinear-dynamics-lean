#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-gue-law-from-coordinates-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/finite-gue-law-from-coordinates-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,534 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 21 \
  -annotate +70+88 'DEVELOPMENT NOTEBOOK / FINITE GUE' \
  -fill '#16243A' -font Palatino-Roman -pointsize 57 \
  -annotate +68+160 'Gaussian coordinates' \
  -fill '#16243A' -font Palatino-Roman -pointsize 54 \
  -annotate +70+225 'become a matrix law' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +72+278 'Fix every variance. Prove every law. Push forward once.' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 72,318 333,397 14,14' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 17 \
  -annotate +102+348 'REAL DIAGONAL BLOCK' \
  -font Helvetica -pointsize 15 -annotate +128+377 'variance  1 / n' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 72,417 333,502 14,14' \
  -fill '#284E72' -stroke none -font Helvetica -pointsize 16 \
  -annotate +92+447 'COMPLEX UPPER BLOCK' \
  -font Helvetica -pointsize 14 -annotate +100+476 'Re  1 / (2n)   Im  1 / (2n)' \
  -stroke '#A67C52' -strokewidth 4 -fill none \
  -draw 'line 346,357 390,357 line 390,357 420,410 line 346,459 390,459 line 390,459 420,410' \
  -fill '#A67C52' -stroke '#A67C52' \
  -draw 'line 420,410 447,410 polygon 459,410 443,398 443,422' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 462,365 690,456 15,15' \
  -fill '#934F1F' -stroke none -font Helvetica -pointsize 17 \
  -annotate +494+400 'PRODUCT COORDINATE' \
  -font Helvetica -pointsize 16 -annotate +548+430 'LAW' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 703,410 744,410 polygon 756,410 740,398 740,422' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 760,65 1132,505 28,28' \
  -fill '#C16F2C' -stroke none -font Helvetica -pointsize 18 \
  -annotate +832+105 'MEASURABLE PUSHFORWARD' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +848+132 'direct Hermitian assembly' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 808,165 1084,388 18,18' \
  -fill '#284E72' -stroke none -font Palatino-Roman -pointsize 28 \
  -annotate +842+215 'GUE matrix law' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +846+252 'probability measure' \
  -annotate +846+286 'exact diagonal law' \
  -annotate +846+320 'exact upper-entry law' \
  -annotate +846+354 'zero dimension is Dirac' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 808,413 1084,471 12,12' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 14 \
  -annotate +846+448 'INVARIANCE COMES LATER' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 16 \
  -annotate +70+580 'EXACT LAWS  /  BLOCK INDEPENDENCE  /  HERMITIAN PUSHFORWARD  /  ZERO-DIRAC BOUNDARY' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "finite-gue-law-from-coordinates-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-gue-law-from-coordinates-card.png"
fi
