#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/koopman-operator-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/koopman-operator-glossary-card.XXXXXX")"
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
  -annotate +68+76 'KNOWLEDGE BASE / GLOSSARY' \
  -fill '#16243A' -font Palatino-Roman -pointsize 56 \
  -annotate +67+148 'Koopman operator' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+190 'Move states forward. Pull observables back by composition.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,228 1132,502 18,18' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 96,278 344,428 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +139+316 'STATE MOTION' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +130+356 'starting state' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 151,378 289,378 polygon 289,378 271,367 271,389' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 15 \
  -annotate +207+407 'updated state' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 360,353 424,353 polygon 424,353 406,342 406,364' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 438,258 762,448 14,14' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +492+299 'OBSERVABLE PULLBACK' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +493+340 'compose with the state update' \
  -annotate +498+373 'then read at the starting state' \
  -fill '#47633B' -font Helvetica-Bold -pointsize 15 \
  -annotate +539+416 'SAME READING' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 776,353 840,353 polygon 840,353 822,342 822,364' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 854,278 1104,428 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +897+316 'MEASURE GATE' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +887+354 'exact norm preservation' \
  -annotate +896+382 'isometry need not be onto' \
  -annotate +911+408 'no inverse assumed' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 13 \
  -annotate +96+480 'THE FIXED SUBSPACE SURVIVES OPERATOR AVERAGING' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'NONLINEAR STATE MAP  /  LINEAR OBSERVABLE OPERATOR  /  REAL SQUARE-INTEGRABLE GEOMETRY' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "koopman-operator-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified koopman-operator-card.png"
fi
