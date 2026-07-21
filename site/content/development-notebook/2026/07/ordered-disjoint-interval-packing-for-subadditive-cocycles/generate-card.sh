#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/ordered-disjoint-interval-packing-for-subadditive-cocycles-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/ordered-disjoint-packing-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 20 \
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / ORDERED INTERVAL PACKING' \
  -fill '#16243A' -font Palatino-Roman -pointsize 54 \
  -annotate +67+145 'Pack the marked starts' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Choose leftmost intervals, cover every mark, and keep the cost finite.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,226 808,490 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +95+263 'MARKED STARTS ON ONE FINITE HORIZON' \
  -fill none -stroke '#7F786D' -strokewidth 3 \
  -draw 'line 104,382 772,382 line 104,370 104,394 line 772,370 772,394' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 142,306 316,417 11,11' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 360,306 555,417 11,11' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 606,306 736,417 11,11' \
  -fill '#FFFDF8' -stroke '#2C2924' -strokewidth 2 \
  -draw 'circle 198,382 207,382 circle 267,382 276,382 circle 425,382 434,382 circle 512,382 521,382 circle 676,382 685,382' \
  -fill '#A67C52' -stroke '#2C2924' -strokewidth 2 \
  -draw 'polygon 158,366 168,382 158,398 148,382 polygon 378,366 388,382 378,398 368,382 polygon 624,366 634,382 624,398 614,382' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +155+451 'FILLED DIAMOND = SELECTED START' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +160+476 'three ordered intervals cover all eight marks' \
  -fill '#EDE8E1' -stroke '#7F786D' -strokewidth 2 \
  -draw 'roundrectangle 846,226 1132,344 16,16' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +879+263 'EMPTY MARKS' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +874+298 'weak bound if H+m > 0' \
  -annotate +884+322 'zero marked-card RHS' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 846,372 1132,490 16,16' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +883+409 'NONEMPTY MARKS' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +892+444 'strict conclusion allowed' \
  -annotate +879+468 'at least one interval exists' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'FINITE PACKING  /  WEAK EMPTY CASE  /  NO DENSITY OR LIMIT THEOREM' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "ordered-disjoint-interval-packing-for-subadditive-cocycles-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified ordered-disjoint-interval-packing-for-subadditive-cocycles-card.png"
fi
