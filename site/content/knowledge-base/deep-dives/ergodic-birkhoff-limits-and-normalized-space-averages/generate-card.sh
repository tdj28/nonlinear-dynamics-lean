#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/ergodic-birkhoff-limits-and-normalized-space-averages-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/ergodic-birkhoff-normalized-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 18 \
  -annotate +68+76 'KNOWLEDGE BASE / DEEP DIVE' \
  -fill '#16243A' -font Palatino-Roman -pointsize 43 \
  -annotate +67+142 'Ergodic Birkhoff limits' \
  -annotate +67+194 'and normalized averages' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+250 'Convergence finds an invariant target.' \
  -annotate +70+279 'Rigidity and finite mass identify its one value.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 66,336 566,448 16,16' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +104+374 'THE SUMMIT' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +104+406 'Time averages converge almost everywhere' \
  -annotate +104+429 'to the normalized space average.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 632,62 1136,506 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 680,92 1088,158 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +808+132 'TIME AVERAGE' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,164 884,196 polygon 877,189 891,189 884,200' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 680,208 1088,274 13,13' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +790+248 'INVARIANT TARGET' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,280 884,312 polygon 877,305 891,305 884,316' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 680,324 1088,390 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +807+364 'ONE CONSTANT' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,396 884,424 polygon 877,417 891,417 884,428' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 680,436 1088,482 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +760+465 'NORMALIZED SPACE AVERAGE' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'MEASURE PRESERVATION  /  NULL-OR-CONULL INVARIANTS  /  FINITE POSITIVE MASS' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "ergodic-birkhoff-limits-and-normalized-space-averages-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified ergodic-birkhoff-limits-and-normalized-space-averages-card.png"
fi
