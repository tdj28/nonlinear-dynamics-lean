#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/probability-and-ergodic-base-interfaces-for-matrix-cocycles-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/probability-ergodic-base-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / PROBABILITY AND ERGODIC BASES' \
  -fill '#16243A' -font Palatino-Roman -pointsize 48 \
  -annotate +67+145 'Three gates, three different jobs' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Integrability controls finite horizons. Probability fixes scale. Ergodicity rigidifies invariants.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 68,240 396,476 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +151+280 'INTEGRABILITY' \
  -fill '#FFFDF8' -stroke '#4B6787' -strokewidth 1.3 \
  -draw 'roundrectangle 98,312 366,362 10,10 roundrectangle 98,389 366,439 10,10' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +136+343 'PROCESS CANDIDATE' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +134+420 'DETERMINISTIC RATE BOUNDS' \
  -fill '#F5EBCF' -stroke '#A98845' -strokewidth 2 \
  -draw 'roundrectangle 436,240 764,476 18,18' \
  -fill '#775F25' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +505+280 'PROBABILITY MASS ONE' \
  -fill '#FFFDF8' -stroke '#A98845' -strokewidth 1.3 \
  -draw 'roundrectangle 466,312 734,362 10,10 roundrectangle 466,389 734,439 10,10' \
  -fill '#775F25' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +529+337 'EXPECTATION' \
  -fill '#5A544C' -font Helvetica -pointsize 12 \
  -annotate +527+354 '+ INTEGRABILITY' \
  -fill '#775F25' -font Helvetica-Bold -pointsize 14 \
  -annotate +519+414 'ZERO-ONE EVENT' \
  -fill '#5A544C' -font Helvetica -pointsize 12 \
  -annotate +535+432 '+ ERGODICITY' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 804,240 1132,476 18,18' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +902+280 'ERGODICITY' \
  -fill '#FFFDF8' -stroke '#A67C52' -strokewidth 1.3 \
  -draw 'roundrectangle 834,312 1102,362 10,10 roundrectangle 834,389 1102,439 10,10' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +870+343 'INVARIANT EVENTS RIGID' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +878+420 'OBSERVABLES CONSTANT' \
  -fill '#FFFDF8' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +141+576 'EVEN TOGETHER: NO SAMPLEWISE LIMIT, NO KINGMAN THEOREM, NO LYAPUNOV EXPONENT' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "probability-and-ergodic-base-interfaces-for-matrix-cocycles-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified probability-and-ergodic-base-interfaces-for-matrix-cocycles-card.png"
fi
