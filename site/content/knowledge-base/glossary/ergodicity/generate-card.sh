#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/ergodicity-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/ergodicity-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 56 \
  -annotate +67+166 'Ergodicity' \
  -fill '#4D5B6B' -font Helvetica -pointsize 19 \
  -annotate +70+230 'Measure preservation plus' \
  -annotate +70+260 'invariant-set rigidity.' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 66,330 566,438 16,16' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +104+368 'THE INFORMATION TEST' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +104+401 'Invariant measurable outputs become' \
  -annotate +104+424 'constant almost everywhere.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 632,70 1136,486 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 674,108 1094,184 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +777+140 'MEASURE PRESERVATION' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +793+163 'REFERENCE MEASURE STAYS FIXED' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,190 884,222 polygon 877,215 891,215 884,226' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 674,234 1094,326 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +779+268 'INVARIANT-SET RIGIDITY' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +764+295 'EXACT INVARIANTS ARE NULL OR CONULL' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,332 884,364 polygon 877,357 891,357 884,368' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 674,376 1094,444 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +806+417 'FULL ERGODICITY' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+580 'PRESERVE MEASURE  /  NULL-OR-CONULL INVARIANTS  /  ONE VALUE ALMOST EVERYWHERE' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "ergodicity-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified ergodicity-card.png"
fi
