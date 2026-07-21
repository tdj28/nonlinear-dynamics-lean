#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/one-sided-discrete-matrix-cocycle-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+98 'KNOWLEDGE BASE / RANDOM DYNAMICS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 48 \
    -annotate +72+176 'One-sided discrete' \
    -annotate +72+234 'matrix cocycle' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+300 'One generator sampled along a forward base orbit' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 700,62 1148,474 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 738,94 1110,156 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 15 \
    -annotate +825+132 'FORWARD BASE ORBIT' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 924,160 924,184 polygon 917,177 931,177 924,188' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 738,192 1110,254 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 15 \
    -annotate +806+230 'SAMPLE ONE GENERATOR' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 924,258 924,282 polygon 917,275 931,275 924,286' \
    -fill '#16243A' -stroke none \
    -draw 'roundrectangle 738,290 1110,352 14,14' \
    -fill '#FFFDF8' -font Helvetica -pointsize 15 \
    -annotate +800+328 'NEWEST FACTOR ON THE LEFT' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 924,356 924,380 polygon 917,373 931,373 924,384' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 738,388 1110,450 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 15 \
    -annotate +792+426 'SHIFTED LATER BLOCK ACTS SECOND' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'BASE ITERATION  /  ONE GENERATOR  /  ORDERED VALUE  /  SHIFTED SPLIT' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/one-sided-discrete-matrix-cocycle-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "one-sided-discrete-matrix-cocycle-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified one-sided-discrete-matrix-cocycle-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
