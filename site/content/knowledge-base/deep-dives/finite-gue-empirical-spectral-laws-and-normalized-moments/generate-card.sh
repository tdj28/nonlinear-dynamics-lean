#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-gue-empirical-spectral-laws-and-normalized-moments-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+86 'DEEP DIVE / GAUSSIAN UNITARY ENSEMBLE' \
    -fill '#16243A' -font Palatino-Roman -pointsize 42 \
    -annotate +72+151 'Finite empirical spectral laws' \
    -annotate +72+205 'and normalized moments' \
    -fill '#4D5B6B' -font Helvetica -pointsize 18 \
    -annotate +76+258 'From one sampled spectrum to a probability law on measures' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 730,56 1150,476 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 762,91 1118,158 12,12' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 15 \
    -annotate +812+119 'INTRINSIC AND AMBIENT LAWS' \
    -font Helvetica -pointsize 13 -annotate +829+143 'SAME SPECTRAL PUSHFORWARD' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 940,165 940,196' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
    -draw 'roundrectangle 762,202 1118,269 12,12' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 15 \
    -annotate +847+230 'LAW ON EMPIRICAL MEASURES' \
    -font Helvetica -pointsize 13 -annotate +833+254 'PROBABILITY IN EVERY DIMENSION' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 940,276 940,307' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 762,313 928,405 12,12 roundrectangle 952,313 1118,405 12,12' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 14 \
    -annotate +800+343 'GIRY JOIN' \
    -annotate +979+343 'MOMENTS' \
    -font Helvetica -pointsize 12 \
    -annotate +787+369 'MEAN MEASURE' \
    -annotate +977+369 'TRACE ROUTE' \
    -annotate +777+390 'SEPARATE OBJECT' \
    -annotate +966+390 'EXACT FINITE VALUES' \
    -fill '#F8E7DE' -stroke '#B45D3A' -strokewidth 2 \
    -draw 'roundrectangle 762,422 1118,453 10,10' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 12 \
    -annotate +803+442 'NO MEAN-MOMENT INTERCHANGE CLAIM' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'PUSHFORWARD  /  PROBABILITY  /  GIRY JOIN  /  NORMALIZED TRACE MOMENTS' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/finite-gue-empirical-spectral-laws-and-normalized-moments-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "finite-gue-empirical-spectral-laws-and-normalized-moments-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-gue-empirical-spectral-laws-and-normalized-moments-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
