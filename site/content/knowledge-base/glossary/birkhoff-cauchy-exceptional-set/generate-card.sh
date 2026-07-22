#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/birkhoff-cauchy-exceptional-set-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/birkhoff-cauchy-exceptional-set-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 20 \
  -annotate +68+78 'KNOWLEDGE BASE / GLOSSARY' \
  -fill '#16243A' -font Palatino-Roman -pointsize 50 \
  -annotate +67+157 'Birkhoff Cauchy' \
  -annotate +67+216 'exceptional set' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+276 'Every tail still contains a pair of averages' \
  -annotate +70+304 'separated at one fixed scale.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 650,70 1132,488 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 690,98 1092,158 12,12' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +833+135 'TAIL CUTOFF' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 891,163 891,187 polygon 884,180 898,180 891,191' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 690,198 1092,258 12,12' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +817+235 'SEPARATED PAIR' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 891,263 891,287 polygon 884,280 898,280 891,291' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 690,298 1092,358 12,12' \
  -fill '#16243A' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +783+335 'REPEATS IN EVERY TAIL' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 891,363 891,387 polygon 884,380 898,380 891,391' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 690,398 1092,458 12,12' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +803+435 'EXCEPTIONAL STATE' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 68,370 584,444 15,15' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +105+401 'THE COMPLEMENT CONTROLS ONE SCALE' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +106+425 'After one cutoff, every pair is closer than the scale.' \
  -fill '#FFFDF8' -font Helvetica -pointsize 16 \
  -annotate +68+580 'TAIL EVENT  /  FIXED SCALE  /  PERSISTENT FAILURE  /  SCALEWISE COMPLEMENT' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "birkhoff-cauchy-exceptional-set-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified birkhoff-cauchy-exceptional-set-card.png"
fi
