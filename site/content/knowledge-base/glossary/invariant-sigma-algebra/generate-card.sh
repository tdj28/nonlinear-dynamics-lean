#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/invariant-sigma-algebra-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/invariant-sigma-algebra-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 52 \
  -annotate +67+158 'Invariant sigma' \
  -annotate +67+219 'algebra' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+278 'Information unchanged by one exact' \
  -annotate +70+306 'pullback through the dynamics.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 628,70 1138,480 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 670,103 1096,173 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +799+146 'MEASURABLE EVENT' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 883,179 883,215 polygon 876,208 890,208 883,219' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 670,227 1096,297 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +760+270 'EXACT PREIMAGE TEST' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 883,303 883,339 polygon 876,332 890,332 883,343' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 670,351 1096,421 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +791+394 'INVARIANT INFORMATION' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 68,374 566,450 15,15' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +111+405 'EXACT SET EQUALITY' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +110+430 'No null-set completion is hidden in the definition.' \
  -fill '#FFFDF8' -font Helvetica -pointsize 16 \
  -annotate +68+580 'MEASURABLE  /  BACKWARD-SATURATED  /  EXACT  /  NOT NECESSARILY ERGODIC' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "invariant-sigma-algebra-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified invariant-sigma-algebra-card.png"
fi
