#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/uniform-integrability-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/uniform-integrability-card.XXXXXX")"
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
  -annotate +67+153 'Uniform' \
  -annotate +67+210 'integrability' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+268 'One threshold controls every tail in' \
  -annotate +70+296 'the whole function family.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 618,70 1140,478 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 658,101 1100,171 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +802+144 'WHOLE FAMILY' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 879,177 879,210 polygon 872,203 886,203 879,214' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 658,224 1100,294 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +776+267 'ONE THRESHOLD' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 879,300 879,333 polygon 872,326 886,326 879,337' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 658,347 1100,417 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +771+390 'EVERY TAIL SMALL' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 68,360 558,450 15,15' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +106+393 'VITALI BRIDGE' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +106+416 'Almost-everywhere convergence plus uniform tails' \
  -annotate +106+434 'gives integrable-norm convergence.' \
  -fill '#FFFDF8' -font Helvetica -pointsize 16 \
  -annotate +68+580 'COMMON GATE  /  NO MASS ESCAPE  /  FINITE MEASURE  /  INTEGRABLE-NORM LIMIT' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "uniform-integrability-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified uniform-integrability-card.png"
fi
