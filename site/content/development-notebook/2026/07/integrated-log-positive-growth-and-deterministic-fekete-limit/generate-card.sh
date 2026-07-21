#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/integrated-log-positive-growth-and-deterministic-fekete-limit-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/integrated-log-positive-fekete-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / INTEGRATED COCYCLE GROWTH' \
  -fill '#16243A' -font Palatino-Roman -pointsize 44 \
  -annotate +67+142 'Integrate first, then take a deterministic limit' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+185 'Measure preservation turns shifted finite growth into a subadditive sequence of real numbers.' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 68,236 258,478 17,17' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +94+271 'FINITE ENVELOPE' \
  -fill '#FFFDF8' -stroke '#A67C52' -strokewidth 1.3 \
  -draw 'roundrectangle 91,302 235,354 9,9 roundrectangle 91,377 235,429 9,9' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +111+333 'EXPANSION COST' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +105+409 'base point varies' \
  -fill '#A67C52' -stroke none \
  -draw 'polygon 270,353 288,353 288,346 304,357 288,368 288,361 270,361' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 316,236 506,478 17,17' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +347+271 'RAW INTEGRAL' \
  -fill '#FFFDF8' -stroke '#4B6787' -strokewidth 1.3 \
  -draw 'roundrectangle 339,302 483,354 9,9 roundrectangle 339,377 483,429 9,9' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +357+333 'INTEGRATE FIRST' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +360+409 'one real number' \
  -fill '#A67C52' -stroke none \
  -draw 'polygon 518,353 536,353 536,346 552,357 536,368 536,361 518,361' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 564,236 754,478 17,17' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +584+271 'SCALAR SEQUENCE' \
  -fill '#FFFDF8' -stroke '#6F8D5E' -strokewidth 1.3 \
  -draw 'roundrectangle 587,302 731,354 9,9 roundrectangle 587,377 731,429 9,9' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +603+333 'SUBADDITIVE' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +605+409 'horizon remains' \
  -fill '#A67C52' -stroke none \
  -draw 'polygon 766,353 784,353 784,346 800,357 784,368 784,361 766,361' \
  -fill '#F5EBCF' -stroke '#A98845' -strokewidth 2 \
  -draw 'roundrectangle 812,236 976,478 17,17' \
  -fill '#775F25' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +831+271 'POSITIVE TIME' \
  -fill '#FFFDF8' -stroke '#A98845' -strokewidth 1.3 \
  -draw 'roundrectangle 835,302 953,354 9,9 roundrectangle 835,377 953,429 9,9' \
  -fill '#775F25' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +851+333 'NORMALIZE' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +858+409 'divide last' \
  -fill '#A67C52' -stroke none \
  -draw 'polygon 988,353 1006,353 1006,346 1022,357 1006,368 1006,361 988,361' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 1034,236 1132,478 17,17' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +1051+271 'FEKETE' \
  -fill '#FFFDF8' -stroke '#6F8D5E' -strokewidth 1.3 \
  -draw 'roundrectangle 1051,302 1115,354 9,9 roundrectangle 1051,377 1115,429 9,9' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +1065+333 'LIMIT' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +1054+402 'deterministic' \
  -annotate +1061+420 'number' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 13 \
  -annotate +66+575 'EXPLICIT INTEGRABILITY / WITHOUT PROBABILITY NORMALIZATION, NO EXPECTATION CLAIM / NO LYAPUNOV EXPONENT' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "integrated-log-positive-growth-and-deterministic-fekete-limit-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified integrated-log-positive-growth-and-deterministic-fekete-limit-card.png"
fi
