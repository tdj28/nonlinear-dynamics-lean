#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/orbit-majorant-centering-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'KNOWLEDGE BASE / RANDOM DYNAMICS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 42 \
    -annotate +72+160 'Orbit-majorant centering' \
    -fill '#4D5B6B' -font Helvetica -pointsize 19 \
    -annotate +76+218 'Subtract an additive orbit bound, not an expectation.' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 672,66 1128,164 18,18' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
    -annotate +716+106 'FINITE PROCESS' \
    -fill '#4D5B6B' -font Helvetica -pointsize 14 \
    -annotate +716+137 'AT ONE SAMPLE AND HORIZON' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 900,169 900,198 polygon 893,191 907,191 900,202' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 672,210 1128,308 18,18' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 17 \
    -annotate +716+250 'MINUS ONE-STEP ORBIT SUM' \
    -fill '#4D5B6B' -font Helvetica -pointsize 14 \
    -annotate +716+281 'A POINTWISE ADDITIVE MAJORANT' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 900,313 900,342 polygon 893,335 907,335 900,346' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 672,354 1128,462 18,18' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 15 \
    -annotate +700+397 'NONPOSITIVE AT POSITIVE TIME' \
    -fill '#4D5B6B' -font Helvetica -pointsize 14 \
    -annotate +716+429 'STILL SHIFTED-SUBADDITIVE' \
    -fill '#F3E8E0' -stroke '#A55445' -strokewidth 2 \
    -draw 'roundrectangle 72,312 574,384 14,14' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
    -annotate +115+355 'NOT MEAN ZERO. NO LIMIT THEOREM.' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'FINITE ALGEBRA  /  ZERO-TIME BOUNDARY  /  EXACT IDENTITY' \
    -strip -define png:exclude-chunk=date,time \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/orbit-majorant-centering-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "orbit-majorant-centering-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified orbit-majorant-centering-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
