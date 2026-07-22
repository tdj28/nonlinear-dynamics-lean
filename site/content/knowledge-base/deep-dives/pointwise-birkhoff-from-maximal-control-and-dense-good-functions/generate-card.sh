#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/pointwise-birkhoff-from-maximal-control-and-dense-good-functions-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/pointwise-birkhoff-deep-dive-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 20 \
  -annotate +68+78 'KNOWLEDGE BASE / DEEP DIVE' \
  -fill '#16243A' -font Palatino-Roman -pointsize 46 \
  -annotate +67+151 'From maximal control' \
  -annotate +67+207 'to pointwise convergence' \
  -fill '#4D5B6B' -font Helvetica -pointsize 19 \
  -annotate +70+267 'Two inputs meet in one closure argument:' \
  -annotate +70+296 'analytic error control and topological density.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 668,70 1126,138 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +788+112 'WEAK MAXIMAL BOUND' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 668,168 1126,236 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +758+210 'DENSE POINTWISE-GOOD CORE' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 897,142 897,158 polygon 890,151 904,151 897,162 line 897,240 897,276 polygon 890,269 904,269 897,280' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 720,288 1074,366 15,15' \
  -fill '#16243A' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +807+325 'CAUCHY CLOSURE' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +785+348 'FIXED SCALES, THEN A NULL UNION' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 897,372 897,405 polygon 890,398 904,398 897,409' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 720,416 1074,484 15,15' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +788+457 'ALMOST-EVERYWHERE LIMIT' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,356 586,446 15,15' \
  -fill '#16243A' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +106+389 'THE DENSE CLASS IS NOT THE ENDPOINT' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +106+416 'Maximal stability transports convergence to the closure.' \
  -fill '#FFFDF8' -font Helvetica -pointsize 16 \
  -annotate +68+580 'FINITE MEASURE  /  FULL SEQUENCE  /  LIMIT FORMULA STILL OPEN' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "pointwise-birkhoff-from-maximal-control-and-dense-good-functions-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified pointwise-birkhoff-from-maximal-control-and-dense-good-functions-card.png"
fi
