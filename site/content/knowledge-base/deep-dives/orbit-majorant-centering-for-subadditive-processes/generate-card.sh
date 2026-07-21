#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/orbit-majorant-centering-for-subadditive-processes-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'DEEP DIVE / SUBADDITIVE PROCESSES' \
    -fill '#16243A' -font Palatino-Roman -pointsize 36 \
    -annotate +72+158 'Orbit-majorant centering' \
    -annotate +72+204 'before any limit theorem' \
    -fill '#4D5B6B' -font Helvetica -pointsize 18 \
    -annotate +76+262 'Subtract the additive route. Keep the finite slack.' \
    -fill '#F3E8E0' -stroke '#A55445' -strokewidth 2 \
    -draw 'roundrectangle 72,334 604,408 14,14' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 15 \
    -annotate +108+378 'EXACT SPLIT DOES NOT PROVE CONVERGENCE' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 666,54 1148,482 22,22' \
    -fill '#16243A' -stroke none -font Helvetica-Bold -pointsize 13 \
    -annotate +710+92 'FINITE COMPENSATION' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 730,124 1084,188 12,12' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 12 \
    -annotate +808+153 'PROCESS VALUE' \
    -fill '#4D5B6B' -font Helvetica -pointsize 10 \
    -annotate +783+173 'one whole finite horizon' \
    -fill '#A67C52' -stroke none -font Helvetica-Bold -pointsize 20 \
    -annotate +890+222 'SUBTRACT' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
    -draw 'roundrectangle 730,244 1084,308 12,12' \
    -fill '#8B5A33' -stroke none -font Helvetica-Bold -pointsize 12 \
    -annotate +793+273 'ONE-STEP ORBIT SUM' \
    -fill '#4D5B6B' -font Helvetica -pointsize 10 \
    -annotate +790+293 'additive pointwise majorant' \
    -fill '#A67C52' -stroke none -font Helvetica-Bold -pointsize 20 \
    -annotate +906+342 'LEAVES' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 730,364 1084,436 12,12' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 12 \
    -annotate +814+394 'CENTERED RESIDUAL' \
    -fill '#315F55' -font Helvetica -pointsize 10 \
    -annotate +790+417 'nonpositive after time zero' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'FINITE ALGEBRA  /  EXACT BOUNDARIES  /  NO LIMIT CLAIM' \
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
    echo "orbit-majorant-centering-for-subadditive-processes-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified orbit-majorant-centering-for-subadditive-processes-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
