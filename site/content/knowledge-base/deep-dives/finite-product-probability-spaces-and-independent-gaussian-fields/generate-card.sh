#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-gaussian-fields-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'DEEP DIVE / PRODUCT PROBABILITY' \
    -fill '#16243A' -font Palatino-Roman -pointsize 52 \
    -annotate +72+177 'Finite product spaces' \
    -annotate +72+240 'and independent' \
    -annotate +72+303 'Gaussian fields' \
    -fill '#4D5B6B' -font Helvetica -pointsize 21 \
    -annotate +76+363 'Exact laws + mutual independence yield one joint measure' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 742,72 1148,467 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 772,116 930,252 15,15' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +821+158 'EXACT' \
    -annotate +787+188 'COORDINATE' \
    -annotate +826+218 'LAWS' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 960,116 1118,252 15,15' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
    -annotate +1009+158 'MUTUAL' \
    -annotate +976+188 'INDEPENDENCE' \
    -font Helvetica -pointsize 14 -annotate +986+218 'ACROSS BLOCKS' \
    -fill '#7F786D' -stroke none -font Helvetica -pointsize 34 \
    -annotate +937+198 '+' \
    -fill none -stroke '#7F786D' -strokewidth 3 \
    -draw 'line 851,255 910,346 line 1039,255 980,346' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 814,348 1076,436 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 18 \
    -annotate +844+387 'EXACT PRODUCT LAW' \
    -font Helvetica -pointsize 14 -annotate +864+414 'one finite field measure' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'FINITE  /  MEASURABLE  /  MUTUALLY INDEPENDENT  /  EMPTY CASE EXPLICIT' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/finite-gaussian-fields-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "finite-gaussian-fields-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-gaussian-fields-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
