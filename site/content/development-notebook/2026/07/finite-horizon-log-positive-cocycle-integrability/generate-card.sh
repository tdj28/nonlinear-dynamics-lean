#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-horizon-log-positive-cocycle-integrability-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/finite-horizon-log-positive-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / FINITE-HORIZON INTEGRABILITY' \
  -fill '#16243A' -font Palatino-Roman -pointsize 44 \
  -annotate +67+142 'Carry one expansion budget through time' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+185 'Measure-preserving pullbacks and a finite sum control each whole-product envelope.' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 68,226 382,490 18,18' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +154+263 'ONE-STEP COST' \
  -fill '#FFFDF8' -stroke '#A67C52' -strokewidth 1.5 \
  -draw 'roundrectangle 107,300 343,354 10,10 roundrectangle 107,372 343,426 10,10' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +144+332 'POSITIVE LOG OF NORM' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +131+404 'expansion keeps its log cost' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +130+459 'contraction or collapse: zero' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 444,226 756,490 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +500+263 'ORBIT PULLBACKS' \
  -fill '#FFFDF8' -stroke '#4B6787' -strokewidth 1.5 \
  -draw 'roundrectangle 482,300 718,354 10,10 roundrectangle 482,372 718,426 10,10' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +513+332 'BASE ITERATES' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +500+404 'preserve the raw measure' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +507+459 'each copy stays integrable' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 818,226 1132,490 18,18' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +892+263 'FINITE MAJORANT' \
  -fill '#FFFDF8' -stroke '#6F8D5E' -strokewidth 1.5 \
  -draw 'roundrectangle 856,300 1094,354 10,10 roundrectangle 856,372 1094,426 10,10' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +922+332 'ORBIT SUM' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +885+404 'dominates whole-product cost' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +902+459 'every fixed horizon' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'EXPLICIT INTEGRABILITY HYPOTHESIS  /  RAW MEASURE  /  NO LYAPUNOV LIMIT' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "finite-horizon-log-positive-cocycle-integrability-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-horizon-log-positive-cocycle-integrability-card.png"
fi
