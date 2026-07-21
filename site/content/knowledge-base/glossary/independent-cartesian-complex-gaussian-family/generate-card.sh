#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/independent-complex-family-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+100 'KNOWLEDGE BASE / PROBABILITY' \
    -fill '#16243A' -font Palatino-Roman -pointsize 53 \
    -annotate +72+188 'Independent Cartesian' \
    -annotate +72+252 'complex Gaussian family' \
    -fill '#4D5B6B' -font Helvetica -pointsize 21 \
    -annotate +76+316 'Exact coordinate laws plus mutual independence' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 735,82 940,155 14,14 roundrectangle 735,180 940,253 14,14 roundrectangle 735,278 940,351 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 18 \
    -annotate +775+126 'COORDINATE 1' \
    -annotate +775+224 'COORDINATE 2' \
    -annotate +783+322 'FURTHER INDEX' \
    -fill none -stroke '#7F786D' -strokewidth 3 \
    -draw 'line 943,119 985,178 line 943,216 985,201 line 943,314 985,224' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 988,160 1145,244 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
    -annotate +1015+193 'MUTUAL' \
    -annotate +1006+219 'INDEPENDENCE' \
    -fill none -stroke '#7F786D' -strokewidth 3 \
    -draw 'line 1066,247 1066,322' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 970,325 1162,405 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 18 \
    -annotate +1001+373 'PRODUCT LAW' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'MEASURABLE  /  EXACT  /  MUTUALLY INDEPENDENT  /  SCALE VISIBLE' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/independent-complex-family-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "independent-complex-family-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified independent-complex-family-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
