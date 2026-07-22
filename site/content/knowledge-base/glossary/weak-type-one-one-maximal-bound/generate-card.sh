#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/weak-type-one-one-maximal-bound-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/weak-type-one-one-maximal-bound-card.XXXXXX")"
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
  -annotate +68+78 'KNOWLEDGE BASE / GLOSSARY' \
  -fill '#16243A' -font Palatino-Roman -pointsize 47 \
  -annotate +67+153 'Weak type one-one' \
  -annotate +67+210 'maximal bound' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+268 'Large maximal errors can occupy only a' \
  -annotate +70+296 'controlled amount of the state space.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 620,78 1140,456 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 660,108 1100,178 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +781+151 'TOTAL ERROR BUDGET' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 880,184 880,216 polygon 873,209 887,209 880,220' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 660,228 1100,298 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +793+271 'POSITIVE THRESHOLD' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 880,304 880,336 polygon 873,329 887,329 880,340' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 660,348 1100,418 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +745+391 'EXCEPTIONAL-SET MEASURE' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 68,360 566,446 15,15' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +103+392 'EVENT-MEASURE CONTROL' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +104+418 'Not a maximal-function norm bound.' \
  -fill '#FFFDF8' -font Helvetica -pointsize 16 \
  -annotate +68+580 'ERROR BUDGET  /  POSITIVE GATE  /  EVENT BOUND  /  NOT A NORM BOUND' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "weak-type-one-one-maximal-bound-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified weak-type-one-one-maximal-bound-card.png"
fi
