#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/probability-normalization-and-ergodic-rigidity-before-kingman-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'DEEP DIVE / RANDOM COCYCLES' \
    -fill '#16243A' -font Palatino-Roman -pointsize 34 \
    -annotate +72+150 'Probability normalization' \
    -annotate +72+194 'and ergodic rigidity' \
    -annotate +72+238 'before Kingman' \
    -fill '#4D5B6B' -font Helvetica -pointsize 18 \
    -annotate +76+294 'Exact assumptions. Honest theorem boundary.' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 672,54 1148,482 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 698,82 822,136 12,12' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 11 \
    -annotate +718+115 'PROBABILITY' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 848,82 972,136 12,12' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 11 \
    -annotate +873+115 'ERGODICITY' \
    -fill '#F7E9DA' -stroke '#C16F2C' -strokewidth 2 \
    -draw 'roundrectangle 998,82 1122,136 12,12' \
    -fill '#9B5523' -stroke none -font Helvetica-Bold -pointsize 10 \
    -annotate +1012+115 'INTEGRABILITY' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
    -draw 'roundrectangle 698,164 1122,218 12,12' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 11 \
    -annotate +736+197 'RATE FACTS: INTEGRABILITY ONLY' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
    -draw 'roundrectangle 698,238 1122,292 12,12' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 11 \
    -annotate +725+271 'EXPECTATION: PROBABILITY + MOMENT' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
    -draw 'roundrectangle 698,312 1122,366 12,12' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 11 \
    -annotate +723+345 'ZERO-ONE: PROBABILITY + ERGODICITY' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
    -draw 'roundrectangle 698,386 1122,440 12,12' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 11 \
    -annotate +731+419 'INVARIANT CONSTANT: ERGODICITY' \
    -fill '#F3E8E0' -stroke '#A55445' -strokewidth 2 \
    -draw 'roundrectangle 72,354 584,424 14,14' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
    -annotate +118+395 'NO SAMPLEWISE LIMIT THEOREM YET' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'MASS ONE  /  INVARIANT RIGIDITY  /  FINITE MOMENTS' \
    -strip -define png:exclude-chunk=date,time \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/probability-ergodicity-kingman-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "probability-normalization-and-ergodic-rigidity-before-kingman-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified probability-normalization-and-ergodic-rigidity-before-kingman-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
