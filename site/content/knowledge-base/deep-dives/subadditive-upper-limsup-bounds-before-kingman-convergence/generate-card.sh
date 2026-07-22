#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/subadditive-upper-limsup-bounds-before-kingman-convergence-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt29-deep-dive-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 41 \
  -annotate +67+140 'Subadditive upper bounds' \
  -annotate +67+190 'before Kingman convergence' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+246 'Fixed blocks control the eventual upper edge.' \
  -annotate +70+275 'The matching lower mechanism is still absent.' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 66,334 566,451 16,16' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +104+375 'UPPER LIMSUP ONLY' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +104+409 'A one-sided theorem.' \
  -annotate +104+432 'Not convergence. Not equality.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 632,62 1136,506 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 680,92 1088,190 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +794+120 'THREE RESIDUE LANES' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +724+148 'ZERO LANE' -annotate +838+148 'ONE LANE' -annotate +952+148 'TWO LANE' \
  -fill none -stroke '#4B6787' -strokewidth 1 \
  -draw 'roundrectangle 708,133 802,164 7,7 roundrectangle 820,133 914,164 7,7 roundrectangle 932,133 1026,164 7,7' \
  -fill '#4D5B6B' -stroke none -font Helvetica -pointsize 12 \
  -annotate +792+181 'FINITE PHASE BOUND' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,196 884,214 polygon 877,207 891,207 884,218' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 680,226 1088,288 13,13' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +796+264 'ORIGINAL-MAP AVERAGE' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,294 884,320 polygon 877,313 891,313 884,324' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 680,332 1088,394 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +790+370 'UPPER LIMSUP BOUND' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,400 884,426 polygon 877,419 891,419 884,430' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 680,438 1088,482 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +781+466 'LOWER LIMINF MISSING' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'PHASE AVERAGING  /  PROBABILITY GATE  /  FEKETE RATE  /  NO LOWER BOUND' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "subadditive-upper-limsup-bounds-before-kingman-convergence-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified subadditive-upper-limsup-bounds-before-kingman-convergence-card.png"
fi
