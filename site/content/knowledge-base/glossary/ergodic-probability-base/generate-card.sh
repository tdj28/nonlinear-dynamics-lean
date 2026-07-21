#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/ergodic-probability-base-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'KNOWLEDGE BASE / RANDOM DYNAMICS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 42 \
    -annotate +72+160 'Ergodic probability base' \
    -fill '#4D5B6B' -font Helvetica -pointsize 19 \
    -annotate +76+220 'Three assumptions. Three different jobs.' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 684,68 1128,168 18,18' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
    -annotate +714+108 'PROBABILITY' \
    -fill '#4D5B6B' -font Helvetica -pointsize 14 \
    -annotate +714+139 'FIXES THE MEASURE SCALE' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 684,194 1128,294 18,18' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
    -annotate +714+234 'ERGODICITY' \
    -fill '#4D5B6B' -font Helvetica -pointsize 14 \
    -annotate +714+265 'FIXES INVARIANT INFORMATION' \
    -fill '#F7E9DA' -stroke '#C16F2C' -strokewidth 3 \
    -draw 'roundrectangle 684,320 1128,420 18,18' \
    -fill '#9B5523' -stroke none -font Helvetica-Bold -pointsize 16 \
    -annotate +714+360 'INTEGRABILITY' \
    -fill '#4D5B6B' -font Helvetica -pointsize 14 \
    -annotate +714+391 'FIXES FINITE MOMENTS' \
    -fill '#F3E8E0' -stroke '#A55445' -strokewidth 2 \
    -draw 'roundrectangle 72,310 582,382 14,14' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
    -annotate +116+353 'STILL NO SAMPLEWISE LIMIT THEOREM' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'MASS ONE  /  INVARIANT RIGIDITY  /  FINITE MOMENTS' \
    -strip -define png:exclude-chunk=date,time \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/ergodic-probability-base-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "ergodic-probability-base-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified ergodic-probability-base-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
