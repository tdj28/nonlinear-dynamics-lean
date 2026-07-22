#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-bad-block-measure-bounds-before-kingman-lower-liminf-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt30-deep-dive-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 18 \
  -annotate +68+76 'KNOWLEDGE BASE / DEEP DIVE' \
  -fill '#16243A' -font Palatino-Roman -pointsize 39 \
  -annotate +67+140 'Finite bad-block bounds' \
  -annotate +67+188 'before lower liminf' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+246 'Count short failures. Pack their witnesses.' \
  -annotate +70+275 'Integrate first. Reverse negative division.' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 66,334 566,451 16,16' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +105+375 'FINITE MEASURE RATIO' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +105+409 'No lower liminf yet.' \
  -annotate +105+432 'No Kingman convergence.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 632,62 1136,506 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 680,92 1088,158 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +771+132 'SHORT BAD BLOCKS' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,164 884,188 polygon 877,181 891,181 884,192' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 680,200 1088,266 13,13' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +764+240 'VISITS AND WITNESSES' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,272 884,296 polygon 877,289 891,289 884,300' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 680,308 1088,374 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +786+348 'GREEDY PACKING' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,380 884,404 polygon 877,397 891,397 884,408' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 680,416 1088,482 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +773+456 'INTEGRATE AND LIMIT' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'VISIT COUNT  /  NULL MEASURABILITY  /  NEGATIVE DIVISION  /  NO SAMPLE LIMIT' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "finite-bad-block-measure-bounds-before-kingman-lower-liminf-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-bad-block-measure-bounds-before-kingman-lower-liminf-card.png"
fi
