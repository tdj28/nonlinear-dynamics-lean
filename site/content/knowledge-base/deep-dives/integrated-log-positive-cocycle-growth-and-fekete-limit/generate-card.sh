#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/integrated-log-positive-cocycle-growth-and-fekete-limit-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F5F0E6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,20 rectangle 0,536 1200,630' \
    -fill '#C16F2C' -font Helvetica-Bold -pointsize 19 \
    -annotate +72+88 'DEEP DIVE / RANDOM COCYCLES' \
    -fill '#16243A' -font Palatino-Roman -pointsize 37 \
    -annotate +72+152 'Integrate first.' \
    -annotate +72+200 'Normalize second.' \
    -annotate +72+248 'Read Fekete exactly.' \
    -fill '#4D5B6B' -font Helvetica -pointsize 18 \
    -annotate +76+294 'One scalar sequence. One deterministic limit.' \
    -fill '#F4E9E4' -stroke '#A34D40' -strokewidth 2 \
    -draw 'roundrectangle 72,342 598,452 16,16' \
    -fill '#963F35' -stroke none -font Helvetica-Bold -pointsize 16 \
    -annotate +96+377 'ZERO TIME IS A FORMAL BOUNDARY' \
    -fill '#4D3B37' -font Helvetica -pointsize 16 \
    -annotate +96+407 'A_0 = 0, but the infimum uses k >= 1.' \
    -annotate +96+433 'No samplewise or Lyapunov conclusion.' \
    -fill '#FFFDF8' -stroke '#C9BBA6' -strokewidth 2 \
    -draw 'roundrectangle 668,52 1148,498 20,20' \
    -fill '#F4E4CD' -stroke '#B66A2C' -strokewidth 2 \
    -draw 'roundrectangle 700,78 884,148 13,13' \
    -fill '#B66A2C' -stroke none -draw 'circle 728,103 728,117' \
    -fill '#2C2924' -font Helvetica-Bold -pointsize 13 \
    -annotate +748+108 'AMBER / [2]' \
    -fill '#4D5B6B' -font Helvetica -pointsize 12 \
    -annotate +724+134 'mass 1/2; P_1/L = 1' \
    -fill '#DFEAF2' -stroke '#416887' -strokewidth 2 \
    -draw 'roundrectangle 932,78 1116,148 13,13' \
    -fill '#416887' -stroke none -draw 'circle 960,103 960,117' \
    -fill '#2C2924' -font Helvetica-Bold -pointsize 13 \
    -annotate +980+108 'BLUE / [1]' \
    -fill '#4D5B6B' -font Helvetica -pointsize 12 \
    -annotate +956+134 'mass 1/2; P_1/L = 0' \
    -fill none -stroke '#416887' -strokewidth 3 \
    -draw 'line 887,113 926,113 polygon 917,106 929,113 917,120' \
    -fill '#16243A' -stroke none \
    -draw 'roundrectangle 700,184 1116,222 10,10' \
    -fill '#FFFDF8' -font Helvetica-Bold -pointsize 11 \
    -annotate +719+208 'k' \
    -annotate +775+208 'P_a/L' \
    -annotate +862+208 'P_b/L' \
    -annotate +955+208 'I_k/L' \
    -annotate +1047+208 'A_k/L' \
    -fill '#F4E9E4' -stroke none -draw 'rectangle 701,223 1115,271' \
    -fill '#2C2924' -font Helvetica-Bold -pointsize 13 \
    -annotate +721+253 '0' -annotate +797+253 '0' \
    -annotate +884+253 '0' -annotate +971+253 '0' \
    -fill '#963F35' -annotate +1054+253 '0*' \
    -fill '#2C2924' \
    -annotate +721+301 '1' -annotate +797+301 '1' \
    -annotate +884+301 '0' -annotate +966+301 '1/2' \
    -annotate +1050+301 '1/2' \
    -annotate +721+349 '2' -annotate +797+349 '1' \
    -annotate +884+349 '1' -annotate +971+349 '1' \
    -annotate +1050+349 '1/2' \
    -annotate +721+397 '3' -annotate +797+397 '2' \
    -annotate +884+397 '1' -annotate +966+397 '3/2' \
    -annotate +1050+397 '1/2' \
    -fill none -stroke '#D8CEC0' -strokewidth 1 \
    -draw 'line 700,271 1116,271 line 700,319 1116,319 line 700,367 1116,367 line 700,415 1116,415' \
    -fill '#E8F0E3' -stroke '#668253' -strokewidth 2 \
    -draw 'roundrectangle 700,430 1116,474 12,12' \
    -fill '#365B47' -stroke none -font Helvetica-Bold -pointsize 14 \
    -annotate +754+458 'positive A_k = (1/2) log 2' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'EXACT FINITE LEDGER  /  POSITIVE INDICES  /  DETERMINISTIC LIMIT' \
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
