#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/integrated-log-positive-growth-rate-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'KNOWLEDGE BASE / RANDOM DYNAMICS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 41 \
    -annotate +72+158 'Integrated log-positive' \
    -annotate +72+210 'growth rate' \
    -fill '#4D5B6B' -font Helvetica -pointsize 19 \
    -annotate +76+270 'Integrate first. Normalize in time. Apply Fekete.' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 702,54 1148,482 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 738,78 1112,132 13,13' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 13 \
    -annotate +799+111 'FINITE POSITIVE-LOG ENVELOPE' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 925,136 925,155 polygon 918,148 932,148 925,159' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 738,164 1112,218 13,13' \
    -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 13 \
    -annotate +800+197 'INTEGRATE AGAINST RAW MEASURE' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 925,222 925,241 polygon 918,234 932,234 925,245' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 738,250 1112,304 13,13' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 13 \
    -annotate +791+283 'SUBADDITIVE SCALAR SEQUENCE' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 925,308 925,327 polygon 918,320 932,320 925,331' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 738,336 1112,390 13,13' \
    -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 13 \
    -annotate +793+369 'POSITIVE-TIME NORMALIZATION' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 925,394 925,413 polygon 918,406 932,406 925,417' \
    -fill '#16243A' -stroke none \
    -draw 'roundrectangle 738,422 1112,464 13,13' \
    -fill '#FFFDF8' -font Helvetica-Bold -pointsize 13 \
    -annotate +820+448 'DETERMINISTIC FEKETE LIMIT' \
    -fill '#F3E8E0' -stroke '#A55445' -strokewidth 2 \
    -draw 'roundrectangle 72,330 568,392 13,13' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
    -annotate +126+368 'NOT AN ALMOST-SURE OR LYAPUNOV LIMIT' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'RAW MEASURE  /  POSITIVE HORIZONS  /  NO ERGODIC CLAIM' \
    -strip -define png:exclude-chunk=date,time \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/integrated-log-positive-growth-rate-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "integrated-log-positive-growth-rate-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified integrated-log-positive-growth-rate-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
