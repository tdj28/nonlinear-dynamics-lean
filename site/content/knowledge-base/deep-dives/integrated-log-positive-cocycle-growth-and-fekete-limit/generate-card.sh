#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/integrated-log-positive-cocycle-growth-and-fekete-limit-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'DEEP DIVE / RANDOM COCYCLES' \
    -fill '#16243A' -font Palatino-Roman -pointsize 35 \
    -annotate +72+154 'Integrated log-positive' \
    -annotate +72+200 'cocycle growth' \
    -annotate +72+246 'and its Fekete limit' \
    -fill '#4D5B6B' -font Helvetica -pointsize 18 \
    -annotate +76+300 'Exact dependencies. One deterministic scalar limit.' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 686,54 1148,482 22,22' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 10 \
    -annotate +730+91 'ALGEBRA' \
    -fill '#9B5523' -font Helvetica-Bold -pointsize 10 \
    -annotate +850+91 'INTEGRABILITY' \
    -fill '#315F55' -font Helvetica-Bold -pointsize 10 \
    -annotate +1021+91 'ORDER' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 704,108 832,166 12,12' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 10 \
    -annotate +718+142 'SHIFTED BOUND' \
    -fill '#F7E9DA' -stroke '#C16F2C' -strokewidth 2 \
    -draw 'roundrectangle 850,108 978,166 12,12' \
    -fill '#9B5523' -stroke none -font Helvetica-Bold -pointsize 10 \
    -annotate +875+142 'ONE-STEP hC' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 996,108 1124,166 12,12' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 10 \
    -annotate +1033+142 'P(k) >= 0' \
    -fill none -stroke '#4B6787' -strokewidth 3 \
    -draw 'polyline 768,170 768,190 812,212' \
    -fill '#4B6787' -stroke none \
    -draw 'polygon 812,216 803,203 821,203' \
    -fill none -stroke '#C16F2C' -strokewidth 3 \
    -draw 'polyline 914,170 914,190 870,212' \
    -fill '#C16F2C' -stroke none \
    -draw 'polygon 870,216 861,203 879,203' \
    -fill none -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'line 1060,170 1060,210 polygon 1053,203 1067,203 1060,214' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
    -draw 'roundrectangle 704,216 978,276 12,12' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 10 \
    -annotate +738+241 'JUSTIFIED INTEGRAL STEP' \
    -fill '#4D5B6B' -font Helvetica -pointsize 9 \
    -annotate +724+260 'MONOTONE + ADDITIVE + SHIFT IDENTITY' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 996,216 1124,276 12,12' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 10 \
    -annotate +1026+250 'A(k) >= 0' \
    -fill none -stroke '#4B6787' -strokewidth 3 \
    -draw 'line 841,280 841,302 polygon 834,295 848,295 841,306' \
    -fill none -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'line 1060,280 1060,302 polygon 1053,295 1067,295 1060,306' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 704,308 978,360 12,12' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 11 \
    -annotate +773+339 'SUBADDITIVE SEQUENCE' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 996,308 1124,360 12,12' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 10 \
    -annotate +1018+339 'ZERO LOWER BOUND' \
    -fill none -stroke '#4B6787' -strokewidth 3 \
    -draw 'polyline 841,364 841,382 900,404' \
    -fill '#4B6787' -stroke none \
    -draw 'polygon 908,407 892,410 899,395' \
    -fill none -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'polyline 1060,364 1060,382 934,404' \
    -fill '#6F8D5E' -stroke none \
    -draw 'polygon 926,407 935,395 942,410' \
    -fill '#16243A' -stroke none \
    -draw 'roundrectangle 758,408 1076,462 13,13' \
    -fill '#FFFDF8' -font Helvetica-Bold -pointsize 13 \
    -annotate +800+441 'DETERMINISTIC FEKETE LIMIT' \
    -fill '#F3E8E0' -stroke '#A55445' -strokewidth 2 \
    -draw 'roundrectangle 72,356 590,416 13,13' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 15 \
    -annotate +118+392 'NO SAMPLEWISE OR LYAPUNOV CONCLUSION' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'RAW MEASURE  /  POSITIVE INDICES  /  NO ERGODIC CLAIM' \
    -strip -define png:exclude-chunk=date,time \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/integrated-log-positive-cocycle-growth-fekete-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "integrated-log-positive-cocycle-growth-and-fekete-limit-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified integrated-log-positive-cocycle-growth-and-fekete-limit-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
