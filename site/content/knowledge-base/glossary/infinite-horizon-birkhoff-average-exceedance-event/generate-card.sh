#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/infinite-horizon-birkhoff-average-exceedance-event-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/infinite-horizon-exceedance-glossary-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 43 \
  -annotate +67+135 'Infinite-horizon Birkhoff-average' \
  -annotate +67+184 'exceedance event' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+221 'Some positive-time orbit average strictly crosses one fixed threshold.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,255 1132,504 18,18' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 96,301 302,431 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +140+338 'FINITE EVENTS' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +115+374 'later horizons retain witnesses' \
  -annotate +127+399 'time zero never qualifies' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 316,365 386,365 polygon 386,365 368,354 368,376' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 398,285 750,447 14,14' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +463+325 'EXACT INCREASING UNION' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +443+362 'a witness at time k already appears' \
  -annotate +477+387 'at finite horizon k' \
  -fill '#47633B' -font Helvetica-Bold -pointsize 14 \
  -annotate +465+421 'STRICT CROSSING, POSITIVE TIME' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 764,365 834,365 polygon 834,365 816,354 816,376' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 846,301 1104,431 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +887+338 'INFINITE EVENT' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +879+374 'existence, not convergence' \
  -annotate +874+399 'no infinite real maximum' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 13 \
  -annotate +96+480 'FINITE UNION MASS: A CLEAN SUFFICIENT REAL-LIMIT GATE' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'STRICT THRESHOLD  /  POSITIVE TIME  /  EXACT INCREASING UNION' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "infinite-horizon-birkhoff-average-exceedance-event-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified infinite-horizon-birkhoff-average-exceedance-event-card.png"
fi
