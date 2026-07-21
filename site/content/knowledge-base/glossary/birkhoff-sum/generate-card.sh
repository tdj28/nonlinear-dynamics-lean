#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/birkhoff-sum-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'KNOWLEDGE BASE / RANDOM DYNAMICS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 46 \
    -annotate +72+164 'Birkhoff sum' \
    -fill '#4D5B6B' -font Helvetica -pointsize 22 \
    -annotate +76+222 'Sample one observable along a finite orbit.' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 72,300 574,370 14,14' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 21 \
    -annotate +121+343 'FINITE SUM, NOT A LIMIT THEOREM' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 680,64 1132,482 22,22' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 720,94 1092,154 13,13' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 20 \
    -annotate +811+133 'SHORT REMAINDER' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 906,158 906,181 polygon 899,174 913,174 906,185' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 720,190 1092,250 13,13' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 20 \
    -annotate +798+229 'READ THE BLOCK COST' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 906,254 906,277 polygon 899,270 913,270 906,281' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 720,286 1092,346 13,13' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 20 \
    -annotate +783+325 'ADVANCE ONE FULL BLOCK' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 906,350 906,373 polygon 899,366 913,366 906,377' \
    -fill '#16243A' -stroke none \
    -draw 'roundrectangle 720,382 1092,446 13,13' \
    -fill '#FFFDF8' -font Helvetica-Bold -pointsize 20 \
    -annotate +803+422 'ADD THE FINITE SAMPLES' \
    -fill '#FFFDF8' -font Helvetica -pointsize 20 \
    -annotate +72+578 'POWERED ORBIT  /  BLOCK OBSERVABLE  /  FINITE BOOKKEEPING' \
    -strip -define png:exclude-chunk=date,time \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/birkhoff-sum-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "birkhoff-sum-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified birkhoff-sum-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
