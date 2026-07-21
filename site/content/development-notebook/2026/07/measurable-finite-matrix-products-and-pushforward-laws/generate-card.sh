#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/measurable-finite-matrix-products-and-pushforward-laws-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/measurable-finite-products-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / RANDOM MATRIX PRODUCTS' \
  -fill '#16243A' -font Palatino-Roman -pointsize 49 \
  -annotate +67+145 'From sample paths to certified laws' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Order each outcome. Certify the used prefix. Then push mass forward.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 68,226 382,490 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +141+263 'ORDER EACH OUTCOME' \
  -fill '#FFFDF8' -stroke '#4B6787' -strokewidth 1.5 \
  -draw 'roundrectangle 103,301 347,365 11,11 roundrectangle 103,391 347,455 11,11' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +154+328 'EARLY FACTOR' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +150+351 'acts nearest the state' \
  -fill '#284E72' -font Helvetica-Bold -pointsize 16 \
  -annotate +145+418 'NEWEST FACTOR' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +143+441 'written on the left' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 444,226 756,490 18,18' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +485+263 'CERTIFY THE USED PREFIX' \
  -fill '#FFFDF8' -stroke '#A67C52' -strokewidth 1.5 \
  -draw 'roundrectangle 480,301 720,455 11,11' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +535+337 'MEASURABLE' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +522+370 'check every factor before' \
  -annotate +540+394 'the finite horizon' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 600,407 600,421 polygon 600,435 591,417 609,417' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 13 \
  -annotate +522+446 'certificate licenses the law' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 818,226 1132,490 18,18' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +892+263 'PUSH MASS FORWARD' \
  -fill '#FFFDF8' -stroke '#6F8D5E' -strokewidth 1.5 \
  -draw 'roundrectangle 854,301 1096,365 11,11 roundrectangle 854,391 1096,455 11,11' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +917+328 'RAW LAW' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +890+351 'measure on matrix space' \
  -fill '#315F55' -font Helvetica-Bold -pointsize 16 \
  -annotate +887+418 'MASS-ONE WRAPPER' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +891+441 'when the source is probability' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'FINITE TIME ONLY  /  NO INDEPENDENCE  /  NO FACTORIZATION  /  NO ASYMPTOTICS' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "measurable-finite-matrix-products-and-pushforward-laws-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified measurable-finite-matrix-products-and-pushforward-laws-card.png"
fi
