#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/subadditive-upper-limsup-bounds-before-kingman-convergence-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt29-deep-dive-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 40 \
  -annotate +67+136 'Subadditive upper limsup' \
  -annotate +67+182 'before Kingman convergence' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+220 'One sharp block ledger; one honest real-limsup gate.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 67,250 678,510 20,20 roundrectangle 708,250 1133,510 20,20' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +94+284 'UNIFORM TWO-STATE FLIP' \
  -fill '#DCEAF0' -stroke '#315A70' -strokewidth 3 \
  -draw 'circle 145,347 145,315' \
  -fill '#F1DFCF' -stroke '#A5532D' -strokewidth 3 \
  -draw 'circle 319,347 319,315' \
  -fill '#16243A' -stroke none -font Palatino-Roman -pointsize 21 \
  -annotate +139+354 'a' -annotate +313+354 'b' \
  -fill none -stroke '#315A70' -strokewidth 4 \
  -draw 'line 179,331 285,331 polygon 285,331 270,323 270,339' \
  -fill none -stroke '#A5532D' -strokewidth 4 \
  -draw 'line 285,364 179,364 polygon 179,364 194,356 194,372' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 14 \
  -annotate +374+320 'X values through n=8' \
  -annotate +374+347 'even paths: 1/2' \
  -annotate +374+374 'odd errors shrink to 0' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 94,406 651,482 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +119+435 'BLOCK b = 2 IS SHARP' \
  -fill '#16243A' -font Palatino-Bold -pointsize 21 \
  -annotate +119+466 'limsup = 1/2 = (integral X₂)/2' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 17 \
  -annotate +735+284 'THE REAL-LIMSUP BOUNDARY' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 735,306 1106,380 13,13' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +766+335 'Z(n) = −n²' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +766+362 'Z(n)/n = −n has no lower bound' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 735,397 1106,445 13,13' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +770+427 'GENERAL THEOREM REQUIRES hXlower' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 735,460 1106,489 10,10' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +820+482 'WITHOUT IT: 0 ≤ −1 IS FALSE' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'FIXED BLOCKS  /  ORIGINAL-MAP BIRKHOFF  /  EVENTUAL LOWER-BOUND GATE' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "subadditive-upper-limsup-bounds-before-kingman-convergence-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified subadditive-upper-limsup-bounds-before-kingman-convergence-card.png"
fi
