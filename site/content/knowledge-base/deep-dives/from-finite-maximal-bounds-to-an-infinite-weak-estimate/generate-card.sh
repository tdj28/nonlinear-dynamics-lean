#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/from-finite-maximal-bounds-to-an-infinite-weak-estimate-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/infinite-weak-estimate-deep-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 47 \
  -annotate +67+139 'From finite maximal bounds' \
  -annotate +67+191 'to an infinite weak estimate' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+229 'Follow one exact five-state orbit from finite witnesses to the infinite weak bound.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,260 1132,507 18,18' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 92,292 328,432 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +125+326 'FIVE-STATE CYCLE' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +112+361 'g = [5, -4, 0, 0, -1]' \
  -annotate +139+386 'threshold a = 1' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 11 \
  -annotate +113+412 'STRICT: STATE 2 HITS EQUALITY' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 338,362 380,362 polygon 380,362 364,352 364,372' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 392,280 674,444 14,14' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +435+317 'NESTED FINITE EVENTS' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +427+350 'E1 = {0}' \
  -annotate +427+374 'E2 = {0, 4}' \
  -annotate +427+398 'E3 = {0, 3, 4}' \
  -fill '#47633B' -font Helvetica-Bold -pointsize 11 \
  -annotate +427+425 'EXACT INCREASING UNION' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 684,362 726,362 polygon 726,362 710,352 710,372' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 738,292 904,432 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +769+326 'UNION MASS' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +782+364 'mu(E) = 3/5' \
  -annotate +757+389 'extended measure first' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 10 \
  -annotate +759+414 'REAL VIEW NEEDS A GATE' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 914,362 946,362 polygon 946,362 930,352 930,372' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 958,280 1112,444 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +976+317 'WEAK BOUND' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +990+355 '3/5 <= 1' \
  -annotate +974+381 'positive division' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 12 \
  -annotate +978+414 'NO POINTWISE' \
  -annotate +987+431 'CONVERGENCE' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 13 \
  -annotate +95+480 'Finite witnesses build the union. Extended measure crosses the limit before real conversion.' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'EXACT FIVE-STATE LEDGER  /  EXTENDED MEASURE FIRST  /  POSITIVE DIVISION' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "from-finite-maximal-bounds-to-an-infinite-weak-estimate-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified from-finite-maximal-bounds-to-an-infinite-weak-estimate-card.png"
fi
