#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/gue-first-exact-trace-moments-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/gue-first-exact-trace-moments-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / RMT-09' \
  -fill '#16243A' -font Palatino-Roman -pointsize 57 \
  -annotate +67+148 'First trace moments, exactly' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+190 'Prove integrability. Center the trace. Measure Hermitian energy.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 68,220 555,505 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +100+256 'TRACE POWER ONE' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 100,279 523,344 11,11 roundrectangle 100,372 523,437 11,11' \
  -fill '#4D5B6B' -stroke none -font Helvetica -pointsize 14 \
  -annotate +127+306 'UNNORMALIZED TRACE' \
  -fill '#284E72' -font Palatino-Roman -pointsize 24 \
  -annotate +319+309 'sum of diagonal entries' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 311,350 311,365 polygon 311,374 302,361 320,361' \
  -fill '#4D5B6B' -stroke none -font Helvetica -pointsize 14 \
  -annotate +126+400 'EXACT COMPLEX MEANS' \
  -fill '#284E72' -font Palatino-Roman -pointsize 24 \
  -annotate +346+404 'all centered' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 173,453 450,489 10,10' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +209+478 'INTEGRAL = 0' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 645,220 1132,505 18,18' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +677+256 'TRACE POWER TWO' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 1.5 \
  -draw 'roundrectangle 677,279 1100,344 11,11 roundrectangle 677,372 1100,437 11,11' \
  -fill '#4D5B6B' -stroke none -font Helvetica -pointsize 14 \
  -annotate +703+306 'HERMITIAN IDENTITY' \
  -fill '#934F1F' -font Palatino-Roman -pointsize 24 \
  -annotate +878+309 'Frobenius energy' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 888,350 888,365 polygon 888,374 879,361 897,361' \
  -fill '#4D5B6B' -stroke none -font Helvetica -pointsize 14 \
  -annotate +704+400 'NORMALIZED REAL INDEX' \
  -fill '#934F1F' -font Palatino-Roman -pointsize 22 \
  -annotate +899+404 'n^2 Gaussian squares' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 750,453 1027,489 10,10' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +793+478 'INTEGRAL = n' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'INTEGRABILITY FIRST  /  EXACT FINITE DIMENSION  /  WIGNER SCALE  /  INCLUDES n = 0' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "gue-first-exact-trace-moments-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified gue-first-exact-trace-moments-card.png"
fi
