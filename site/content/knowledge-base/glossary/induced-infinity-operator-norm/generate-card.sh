#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/induced-infinity-operator-norm-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+98 'KNOWLEDGE BASE / MATRIX NORMS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 50 \
    -annotate +72+184 'Induced infinity' \
    -annotate +72+246 'operator norm' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+310 'Maximum row sum controls vector supremum growth' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 700,64 1154,470 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 742,100 1112,164 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +820+139 'TAKE ABSOLUTE ENTRY SIZES' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 927,168 927,198 polygon 920,191 934,191 927,202' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 742,206 1112,270 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
    -annotate +835+245 'ADD WITHIN EACH ROW' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 927,274 927,304 polygon 920,297 934,297 927,308' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 742,312 1112,376 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 16 \
    -annotate +824+351 'KEEP THE LARGEST ROW TOTAL' \
    -fill '#16243A' -stroke none \
    -draw 'roundrectangle 742,394 1112,444 12,12' \
    -fill '#FFFDF8' -font Helvetica -pointsize 15 \
    -annotate +782+426 'BOUND EVERY OUTPUT COORDINATE' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'ROW SUM  /  SUBMULTIPLICATIVE  /  VECTOR ACTION  /  POSITIVE DIMENSION' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/induced-infinity-operator-norm-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "induced-infinity-operator-norm-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified induced-infinity-operator-norm-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
