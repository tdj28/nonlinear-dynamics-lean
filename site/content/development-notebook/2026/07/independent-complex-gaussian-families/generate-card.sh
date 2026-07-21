#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/independent-complex-gaussian-families-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/independent-complex-gaussian-families-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,534 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 21 \
  -annotate +70+91 'DEVELOPMENT NOTEBOOK / FINITE PROBABILITY' \
  -fill '#16243A' -font Palatino-Roman -pointsize 59 \
  -annotate +68+177 'Independent complex' \
  -fill '#16243A' -font Palatino-Roman -pointsize 51 \
  -annotate +70+242 'Gaussian families' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +72+303 'Exact coordinate laws + mutual independence yield a finite product law' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 731,64 1132,500 28,28' \
  -fill '#C16F2C' -stroke none -font Helvetica -pointsize 17 \
  -annotate +782+104 'MUTUAL INDEPENDENCE ACROSS INDICES' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 775,144 897,218 13,13 roundrectangle 775,245 897,319 13,13 roundrectangle 775,346 897,420 13,13' \
  -fill '#284E72' -stroke none -font Helvetica -pointsize 18 \
  -annotate +807+177 'Z i' \
  -font Helvetica -pointsize 14 -annotate +795+201 'exact law' \
  -font Helvetica -pointsize 18 -annotate +807+278 'Z j' \
  -font Helvetica -pointsize 14 -annotate +795+302 'exact law' \
  -font Helvetica -pointsize 18 -annotate +810+379 '...' \
  -font Helvetica -pointsize 14 -annotate +790+403 'finite family' \
  -stroke '#A67C52' -strokewidth 4 -fill '#A67C52' \
  -draw 'line 910,181 963,181 polygon 963,181 948,169 948,193' \
  -draw 'line 910,282 963,282 polygon 963,282 948,270 948,294' \
  -draw 'line 910,383 963,383 polygon 963,383 948,371 948,395' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 975,143 1088,421 14,14' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 17 \
  -annotate +995+258 'JOINT' \
  -annotate +990+289 'PRODUCT' \
  -annotate +1007+320 'LAW' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 14 \
  -annotate +774+468 'WITHIN COORDINATES  +  ACROSS COORDINATES' \
  -fill '#284E72' -stroke '#284E72' -strokewidth 2 \
  -draw 'roundrectangle 72,350 325,400 13,13' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 16 \
  -annotate +91+382 'EXACT COORDINATE LAWS' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 72,418 325,468 13,13' \
  -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
  -annotate +102+450 'MUTUAL INDEPENDENCE' \
  -stroke '#A67C52' -strokewidth 4 -fill none \
  -draw 'line 337,375 376,375 line 376,375 391,409 line 337,443 376,443 line 376,443 391,409' \
  -fill '#A67C52' -stroke '#A67C52' \
  -draw 'line 391,409 408,409 polygon 420,409 404,397 404,421' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 420,363 699,463 14,14' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 19 \
  -annotate +474+404 'FINITE PRODUCT LAW' \
  -font Helvetica -pointsize 14 -annotate +507+436 'joint measure' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 16 \
  -annotate +70+580 'REAL SCALING  /  EXACT MARGINALS  /  EMPTY FAMILY  /  NO GUE CHOICE' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "independent-complex-gaussian-families-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified independent-complex-gaussian-families-card.png"
fi
