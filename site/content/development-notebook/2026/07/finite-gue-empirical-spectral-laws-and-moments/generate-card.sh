#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-gue-empirical-spectral-laws-and-moments-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/finite-gue-spectral-law-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 20 \
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / RMT-10C' \
  -fill '#16243A' -font Palatino-Roman -pointsize 49 \
  -annotate +67+145 'From random spectra to a law and its mean' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Keep the sample measure, its probability law, and its barycenter distinct.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 68,226 288,490 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +105+263 'MATRIX SAMPLE' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 103,300 253,425 11,11' \
  -fill '#284E72' -stroke none -font Helvetica -pointsize 16 \
  -annotate +135+336 'Hermitian' \
  -pointsize 14 -annotate +119+374 'Gaussian ensemble' \
  -pointsize 16 \
  -annotate +124+407 'one outcome' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 299,358 333,358 polygon 344,358 329,349 329,367' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 354,226 574,490 18,18' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +382+263 'EMPIRICAL MEASURE' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 389,300 539,425 11,11' \
  -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
  -annotate +416+336 'real atoms' \
  -annotate +409+374 'equal weights' \
  -annotate +410+407 'zero-aware' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 585,358 619,358 polygon 630,358 615,349 615,367' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 640,226 860,490 18,18' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +682+263 'LAW OF MEASURES' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 675,300 825,425 11,11' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 16 \
  -annotate +703+336 'pushforward' \
  -annotate +697+374 'outer mass one' \
  -annotate +699+407 'all dimensions' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 871,358 905,358 polygon 916,358 901,349 901,367' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 926,226 1132,490 18,18' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +966+263 'MEAN MEASURE' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 954,300 1104,425 11,11' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 16 \
  -annotate +992+336 'Giry join' \
  -annotate +981+374 'averages mass' \
  -annotate +975+407 'forgets variation' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'EXPECTED FIRST MOMENT ZERO  /  EXPECTED SECOND MOMENT ONE FOR POSITIVE SIZE  /  NO LIMIT LAW' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "finite-gue-empirical-spectral-laws-and-moments-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-gue-empirical-spectral-laws-and-moments-card.png"
fi
