#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/countably-generated-centered-lower-deviation-events-in-lean-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt32-notebook-card.XXXXXX")"
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
  -annotate +68+77 'DEVELOPMENT NOTEBOOK / MILESTONE 32' \
  -fill '#16243A' -font Palatino-Roman -pointsize 40 \
  -annotate +67+143 'Countably generated centered' \
  -annotate +67+192 'lower-deviation events' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+248 'Rational slack makes strict deviation countable and shift-stable.' \
  -annotate +70+276 'Finite-measure rigidity and probability select different steps.' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 66,334 574,463 16,16' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +100+374 'ASSUMPTIONS STAY VISIBLE' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +100+408 'Ergodicity gives null or full.' \
  -annotate +100+435 'Probability rules out full.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 626,62 1136,506 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 674,84 1088,143 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +752+121 'CHOOSE A RATIONAL MARGIN' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 881,149 881,174 polygon 874,167 888,167 881,178' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 674,186 1088,245 13,13' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +761+223 'RELAX ACROSS ONE SHIFT' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 881,251 881,276 polygon 874,269 888,269 881,280' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 674,288 1088,347 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +759+325 'GET NULL OR FULL' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 881,353 881,378 polygon 874,371 888,371 881,382' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 674,390 1088,474 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +761+423 'EXCLUDE THE FULL BRANCH' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 14 \
  -annotate +795+450 'STRICT SUBUNIT MASS' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'RATIONAL SLACK  /  ERGODIC RIGIDITY  /  PROBABILITY  /  LEAN CHECKED' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "countably-generated-centered-lower-deviation-events-in-lean-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified countably-generated-centered-lower-deviation-events-in-lean-card.png"
fi
