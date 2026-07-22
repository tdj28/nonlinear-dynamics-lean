#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
card_name="real-log-norm-integrability-from-forward-and-inverse-tails-in-lean-card.png"
checked="$script_dir/$card_name"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt34-notebook-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 17 \
  -annotate +68+77 'DEVELOPMENT NOTEBOOK / MILESTONE 34' \
  -fill '#16243A' -font Palatino-Roman -pointsize 34 \
  -annotate +67+128 'Real log-norm integrability' \
  -annotate +67+170 'from forward and inverse tails' \
  -fill '#4D5B6B' -font Helvetica -pointsize 16 \
  -annotate +70+216 'Pointwise units restore the signed algebra.' \
  -annotate +70+242 'Two integrable rails control every finite horizon.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 64,290 592,500 22,22' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +100+329 'THREE SEPARATELY STORED DUTIES' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 98,350 558,389 12,12' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +184+376 'POINTWISE MATRIX UNITS' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 98,401 558,440 12,12' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +169+427 'FORWARD EXPANSION TAIL' \
  -fill '#F4E5E2' -stroke '#8B3E33' -strokewidth 2 \
  -draw 'roundrectangle 98,452 558,491 12,12' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +169+478 'INVERSE CONTRACTION TAIL' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 626,62 1136,506 22,22' \
  -fill '#315F55' -stroke none -strokewidth 0 \
  -draw 'roundrectangle 678,112 1084,165 14,14' \
  -fill '#FFFFFF' -font Helvetica-Bold -pointsize 15 \
  -annotate +765+145 'FORWARD INTEGRABLE RAIL' \
  -fill none -stroke '#315F55' -strokewidth 7 \
  -draw 'bezier 678,205 790,174 926,227 1084,194' \
  -fill none -stroke '#16243A' -strokewidth 5 \
  -draw 'bezier 678,280 795,241 930,314 1084,265' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 724,286 1038,338 14,14' \
  -fill '#16243A' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +762+318 'SIGNED REAL LOG NORM' \
  -fill none -stroke '#8B3E33' -strokewidth 7 \
  -draw 'bezier 678,400 792,366 928,425 1084,381' \
  -fill '#8B3E33' -stroke none \
  -draw 'roundrectangle 678,430 1084,483 14,14' \
  -fill '#FFFFFF' -font Helvetica-Bold -pointsize 15 \
  -annotate +760+463 'INVERSE INTEGRABLE RAIL' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'MATRIX UNITS  /  TWO-SIDED DOMINATION  /  LEAN CHECKED' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "$card_name is stale; regenerate it" >&2
    exit 1
  }
  echo "verified $card_name"
fi
