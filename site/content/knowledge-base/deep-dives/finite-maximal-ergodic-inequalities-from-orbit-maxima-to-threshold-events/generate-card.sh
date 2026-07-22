#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-maximal-ergodic-inequalities-from-orbit-maxima-to-threshold-events-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/finite-hopf-maximal-deep-card.XXXXXX")"
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
  -annotate +68+76 'KNOWLEDGE BASE / DEEP DIVE' \
  -fill '#16243A' -font Palatino-Roman -pointsize 47 \
  -annotate +67+139 'From orbit maxima to threshold events' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+181 'Peel a positive finite maximizer, cancel its shift, then earn the weak estimate.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,216 1132,508 18,18' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 94,260 306,390 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +130+296 'PARTIAL-SUM PATH' \
  -fill none -stroke '#7F786D' -strokewidth 2 \
  -draw 'line 122,353 278,353' \
  -fill none -stroke '#4B6787' -strokewidth 4 \
  -draw 'polyline 126,353 164,329 202,365 240,306 278,322' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'circle 240,306 248,306' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 13 \
  -annotate +120+379 'strict positive witness' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 314,326 366,326 polygon 366,326 350,316 350,336' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 378,260 590,390 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +440+296 'PEEL + SHIFT' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +415+332 'first value pays for' \
  -annotate +411+356 'the maximum difference' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 598,326 650,326 polygon 650,326 634,316 634,336' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 662,260 874,390 14,14' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +698+296 'CANCEL INTEGRALS' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +700+332 'measure preservation' \
  -annotate +696+356 'makes the shift vanish' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 882,326 934,326 polygon 934,326 918,316 918,336' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 946,246 1106,404 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +979+282 'THRESHOLD' \
  -annotate +982+305 'WEAK BOUND' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +966+344 'finite total mass' \
  -annotate +974+366 'positive threshold' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 13 \
  -annotate +95+450 'FINITE HORIZON ONLY' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +95+476 'Infinite supremum and pointwise convergence remain future work.' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'STRICT EVENT  /  PRESERVING SHIFT  /  HORIZON-UNIFORM CONTROL' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "finite-maximal-ergodic-inequalities-from-orbit-maxima-to-threshold-events-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-maximal-ergodic-inequalities-from-orbit-maxima-to-threshold-events-card.png"
fi
