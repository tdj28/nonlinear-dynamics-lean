#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-maximal-ergodic-inequality-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/finite-maximal-ergodic-inequality-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 49 \
  -annotate +67+143 'Finite maximal ergodic inequality' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+185 'Select a strict positive finite maximum, peel one value, and cancel the shift.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,222 760,504 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +96+260 'FINITE PARTIAL SUMS' \
  -fill none -stroke '#7F786D' -strokewidth 2 \
  -draw 'line 116,434 712,434 line 116,294 116,466' \
  -fill none -stroke '#4B6787' -strokewidth 4 \
  -draw 'polyline 130,434 222,390 314,451 406,335 498,372 590,310 690,344' \
  -fill '#FBF9F6' -stroke '#2C2924' -strokewidth 2 \
  -draw 'circle 130,434 138,434' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'circle 590,310 600,310' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 14 \
  -annotate +120+474 'time zero anchors the maximum at or above zero' \
  -fill '#47633B' -font Helvetica-Bold -pointsize 15 \
  -annotate +498+289 'STRICT POSITIVE WITNESS' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 804,222 1132,326 16,16' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +860+260 'PEEL ONE VALUE' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +842+294 'maximum change <= observable' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 804,350 1132,454 16,16' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +857+388 'CANCEL THE SHIFT' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +838+422 'preservation makes the integrals equal' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 13 \
  -annotate +820+490 'FINITE HORIZON: no convergence theorem' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'STRICT EVENT  /  POINTWISE PEELING  /  INTEGRAL CANCELLATION' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "finite-maximal-ergodic-inequality-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-maximal-ergodic-inequality-card.png"
fi
