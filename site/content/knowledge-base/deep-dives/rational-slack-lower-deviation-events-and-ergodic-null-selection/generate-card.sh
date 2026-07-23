#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/rational-slack-lower-deviation-events-and-ergodic-null-selection-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt32-deep-dive-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 38 \
  -annotate +67+137 'Rational slack and ergodic null selection' \
  -annotate +67+181 'from one exact two-state ledger' \
  -fill '#4D5B6B' -font Helvetica -pointsize 17 \
  -annotate +70+222 'A nonempty raw event can still be almost invariant and have probability zero.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 66,250 680,510 18,18 roundrectangle 708,250 1134,510 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +94+283 'TWO-STATE COLLAPSE' \
  -fill '#DCEAF0' -stroke '#315A70' -strokewidth 3 \
  -draw 'circle 143,344 143,312' \
  -fill '#F1DFCF' -stroke '#A5532D' -strokewidth 3 \
  -draw 'circle 315,344 315,312' \
  -fill '#16243A' -stroke none -font Palatino-Roman -pointsize 20 \
  -annotate +137+351 'a' -annotate +309+351 'b' \
  -fill none -stroke '#315A70' -strokewidth 4 \
  -draw 'line 177,344 279,344 polygon 279,344 264,336 264,352' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 14 \
  -annotate +93+394 'mass(a)=0; mass(b)=1' \
  -annotate +357+324 'X(n,a)=-2(n-1)' \
  -annotate +357+350 'X(n,b)=-(n-1)' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 93,420 652,486 12,12' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +118+449 'inner slope q=-3/2  <  target slope c=-5/4' \
  -fill '#16243A' -font Palatino-Bold -pointsize 20 \
  -annotate +118+478 'a crosses q at every n ≥ 5; b never crosses q' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 16 \
  -annotate +735+283 'SET AND MEASURE LEDGER' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 735,306 1107,377 12,12' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +766+335 'STRICT EVENT D(c) = {a}' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +766+361 'preimage D(c) = empty; both masses are 0' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 735,395 1107,446 12,12' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +778+427 'ERGODIC FORK: mass is 0 or 1' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 735,461 1107,490 10,10' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +819+483 '0 ≤ 4/5 < 1  SELECTS MASS 0' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'FIXED RATIONAL SLACK  /  ALMOST INVARIANCE  /  PROBABILITY BRANCH SELECTION' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "rational-slack-lower-deviation-events-and-ergodic-null-selection-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified rational-slack-lower-deviation-events-and-ergodic-null-selection-card.png"
fi
