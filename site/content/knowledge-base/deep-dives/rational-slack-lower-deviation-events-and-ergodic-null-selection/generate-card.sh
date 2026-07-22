#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/rational-slack-lower-deviation-events-and-ergodic-null-selection-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt32-deep-dive-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 37 \
  -annotate +67+137 'Rational-slack lower-deviation events' \
  -annotate +67+183 'and ergodic null selection' \
  -fill '#4D5B6B' -font Helvetica -pointsize 17 \
  -annotate +70+226 'One fixed rational margin survives every cutoff. Each assumption has one job.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 66,270 1134,500 18,18' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 90,300 300,438 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +116+337 'COUNTABLE EVENT' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +113+372 'fixed rational margin' \
  -annotate +111+397 'arbitrarily late blocks' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 310,369 350,369 polygon 350,369 336,360 336,378' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 362,300 572,438 14,14' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +395+337 'RELAXED SHIFT' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +397+372 'one added endpoint' \
  -annotate +399+397 'slightly larger slope' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 582,369 622,369 polygon 622,369 608,360 608,378' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 634,300 844,438 14,14' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +676+337 'ERGODIC FORK' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +672+372 'almost empty' \
  -annotate +672+397 'or almost full' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 854,369 894,369 polygon 894,369 880,360 880,378' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 906,300 1110,438 14,14' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +949+337 'NULL BRANCH' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +935+372 'probability normalization' \
  -annotate +949+397 'strict ratio below one' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'ERGODICITY MAKES THE FORK  /  PROBABILITY PLUS THE BOUND CHOOSES THE BRANCH' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "rational-slack-lower-deviation-events-and-ergodic-null-selection-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified rational-slack-lower-deviation-events-and-ergodic-null-selection-card.png"
fi
