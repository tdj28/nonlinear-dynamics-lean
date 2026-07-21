#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-ordered-interval-packing-for-nonpositive-subadditive-processes-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/finite-ordered-packing-card.XXXXXX")"
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
  -annotate +68+76 'KNOWLEDGE BASE / DEEP DIVE' \
  -fill '#16243A' -font Palatino-Roman -pointsize 50 \
  -annotate +67+145 'Leftmost selection, finite bounds' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Cover every marked start while keeping selected intervals disjoint.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,226 790,518 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +95+263 'LEFTMOST SELECTION IN THREE ROUNDS' \
  -fill none -stroke '#7F786D' -strokewidth 2 \
  -draw 'line 142,319 746,319 line 142,384 746,384 line 142,449 746,449' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 142,292 302,346 8,8 roundrectangle 142,422 302,476 8,8' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 426,357 565,411 8,8 roundrectangle 426,422 565,476 8,8' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 665,422 735,476 8,8' \
  -fill '#A67C52' -stroke '#2C2924' -strokewidth 1.5 \
  -draw 'polygon 158,306 167,319 158,332 149,319 polygon 442,371 451,384 442,397 433,384 polygon 681,436 690,449 681,462 672,449' \
  -fill '#FFFDF8' -stroke '#2C2924' -strokewidth 1.5 \
  -draw 'circle 216,319 224,319 circle 276,319 284,319 circle 442,319 450,319 circle 527,319 535,319 circle 681,319 689,319 circle 718,319 726,319 circle 527,384 535,384 circle 681,384 689,384 circle 718,384 726,384' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +84+323 'ONE' -annotate +84+388 'TWO' -annotate +84+453 'DONE' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +206+339 'cover nearby marks' -annotate +468+404 'next survivor' -annotate +204+508 'ordered intervals cover the original marked set' \
  -fill '#EDE8E1' -stroke '#7F786D' -strokewidth 2 \
  -draw 'roundrectangle 830,226 1132,344 16,16' \
  -fill '#5A544C' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +890+263 'WEAK BOUND' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +865+299 'empty marks are allowed' \
  -annotate +884+323 'only when H+m > 0' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 830,372 1132,490 16,16' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +888+409 'STRICT BOUND' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +866+445 'requires a nonempty marked set' \
  -annotate +889+469 'so an interval exists' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'FINITE COVERING  /  NONPOSITIVE COST  /  NO ERGODIC LIMIT' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "finite-ordered-interval-packing-for-nonpositive-subadditive-processes-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-ordered-interval-packing-for-nonpositive-subadditive-processes-card.png"
fi
