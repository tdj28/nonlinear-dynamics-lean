#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-measure-pointwise-birkhoff-by-maximal-closure-in-lean-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/finite-measure-pointwise-birkhoff-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 16 \
  -annotate +68+78 'DEVELOPMENT NOTEBOOK / POINTWISE ERGODIC CLOSURE' \
  -fill '#16243A' -font Palatino-Roman -pointsize 54 \
  -annotate +67+157 'Pointwise Birkhoff' \
  -annotate +67+220 'closes' \
  -fill '#4D5B6B' -font Helvetica -pointsize 20 \
  -annotate +70+282 'Maximal control turns dense good observables' \
  -annotate +70+312 'into full-sequence convergence almost everywhere.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 642,64 1132,500 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 684,92 1090,158 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +807+133 'DENSE GOOD CORE' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 887,164 887,190 polygon 880,183 894,183 887,194' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 684,200 1090,266 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +768+241 'ABSOLUTE MAXIMAL CONTROL' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 887,272 887,298 polygon 880,291 894,291 887,302' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 684,308 1090,374 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +783+349 'NULL CAUCHY FAILURES' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 887,380 887,406 polygon 880,399 894,399 887,410' \
  -fill '#16243A' -stroke '#16243A' -strokewidth 2 \
  -draw 'roundrectangle 684,416 1090,472 13,13' \
  -fill '#FFFDF8' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +776+451 'ALMOST-EVERYWHERE LIMIT' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 68,366 570,442 15,15' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +101+397 'THE CLOSURE STEP IS THE THEOREM' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +104+423 'Density becomes almost-everywhere convergence.' \
  -fill '#FFFDF8' -font Helvetica -pointsize 16 \
  -annotate +68+580 'FINITE MASS  /  MEASURE PRESERVATION  /  NO ERGODICITY  /  LIMIT NOT IDENTIFIED' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "finite-measure-pointwise-birkhoff-by-maximal-closure-in-lean-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-measure-pointwise-birkhoff-by-maximal-closure-in-lean-card.png"
fi
