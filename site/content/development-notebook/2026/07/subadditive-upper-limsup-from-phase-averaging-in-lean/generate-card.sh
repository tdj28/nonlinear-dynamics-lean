#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/subadditive-upper-limsup-from-phase-averaging-in-lean-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt29-notebook-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 17 \
  -annotate +68+77 'DEVELOPMENT NOTEBOOK / RMT-29' \
  -fill '#16243A' -font Palatino-Roman -pointsize 44 \
  -annotate +67+146 'Subadditive bounds from' \
  -annotate +67+199 'phase averaging' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+254 'Every residue phase returns to the original map.' \
  -annotate +70+282 'Fixed blocks yield a samplewise upper ceiling.' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 66,338 566,451 16,16' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +104+378 'UPPER LIMSUP ONLY' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +104+411 'No lower bound. No convergence.' \
  -annotate +104+434 'No powered-map ergodicity.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 632,62 1136,506 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 680,94 1088,164 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +784+136 'CENTER THE PROCESS' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,170 884,200 polygon 877,193 891,193 884,204' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 680,212 1088,282 13,13' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +760+254 'AVERAGE EVERY RESIDUE PHASE' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,288 884,318 polygon 877,311 891,311 884,322' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 680,330 1088,400 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +770+372 'USE THE ORIGINAL MAP' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,406 884,436 polygon 877,429 891,429 884,440' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 680,448 1088,482 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +793+471 'FIXED-BLOCK CEILING' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'ORDINARY MAP  /  PROBABILITY MASS  /  POSITIVE BLOCKS  /  LEAN CHECKED' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "subadditive-upper-limsup-from-phase-averaging-in-lean-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified subadditive-upper-limsup-from-phase-averaging-in-lean-card.png"
fi
