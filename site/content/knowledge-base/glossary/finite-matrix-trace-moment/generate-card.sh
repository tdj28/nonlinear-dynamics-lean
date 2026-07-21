#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-matrix-trace-moment-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+98 'KNOWLEDGE BASE / RANDOM MATRIX MOMENTS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 48 \
    -annotate +72+184 'Finite matrix' \
    -annotate +72+246 'trace moment' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+310 'Observable, integrability, then complex expectation' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 716,64 1154,470 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 758,102 1112,176 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +829+134 'MATRIX LAW' \
    -font Helvetica -pointsize 14 -annotate +791+158 'FIX THE NORMALIZATION' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 935,182 935,220' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 758,224 1112,312 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
    -annotate +818+256 'INTEGRABILITY GATE' \
    -font Helvetica -pointsize 14 -annotate +798+284 'A SEPARATE THEOREM' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 935,318 935,354' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 758,358 1112,424 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 16 \
    -annotate +806+397 'FINITE EXPECTED TRACE POWER' \
    -fill '#4D5B6B' -font Helvetica -pointsize 13 \
    -annotate +806+453 'MEASURABILITY ALONE IS NOT ENOUGH' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'TRACE POWER  /  BOCHNER INTEGRAL  /  NORMALIZATION  /  NONCLAIMS' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/finite-matrix-trace-moment-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "finite-matrix-trace-moment-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-matrix-trace-moment-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
