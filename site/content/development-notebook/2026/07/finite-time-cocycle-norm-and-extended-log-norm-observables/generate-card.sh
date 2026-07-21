#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-time-cocycle-norm-and-extended-log-norm-observables-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/finite-time-cocycle-norm-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / FINITE-TIME COCYCLE GROWTH' \
  -fill '#16243A' -font Palatino-Roman -pointsize 46 \
  -annotate +67+142 'Measure growth without losing zero' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+185 'Row totals select the norm. The extended logarithm keeps annihilation honest.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 68,226 382,490 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +133+263 'FINITE COCYCLE VALUE' \
  -fill '#FFFDF8' -stroke '#4B6787' -strokewidth 1.5 \
  -draw 'roundrectangle 107,300 343,354 10,10 roundrectangle 107,372 343,426 10,10' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +170+332 'COMPLEX MATRIX' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +151+404 'one checked finite horizon' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +142+459 'no time average or limit' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 444,226 756,490 18,18' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +508+263 'MAXIMUM ROW SUM' \
  -fill '#FFFDF8' -stroke '#A67C52' -strokewidth 1.5 \
  -draw 'roundrectangle 482,300 718,354 10,10 roundrectangle 482,372 718,426 10,10' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +529+332 'ABSOLUTE ROW TOTALS' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +527+404 'keep the largest row' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +509+459 'measurable and finite-time' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 818,226 1132,490 18,18' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +890+263 'EXTENDED LOGARITHM' \
  -fill '#FFFDF8' -stroke '#6F8D5E' -strokewidth 1.5 \
  -draw 'roundrectangle 856,300 1094,354 10,10' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +916+332 'NONZERO: FINITE' \
  -fill '#FFFDF8' -stroke '#A67C52' -strokewidth 1.5 \
  -draw 'roundrectangle 856,372 1094,426 10,10' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +924+404 'ZERO: BOTTOM' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +888+459 'no nonzero assumption' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'MAXIMUM ROW SUM  /  ZERO BECOMES BOTTOM  /  NO LYAPUNOV CLAIM' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "finite-time-cocycle-norm-and-extended-log-norm-observables-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-time-cocycle-norm-and-extended-log-norm-observables-card.png"
fi
