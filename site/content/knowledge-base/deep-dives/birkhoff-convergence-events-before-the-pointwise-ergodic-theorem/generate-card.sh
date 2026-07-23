#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/birkhoff-convergence-events-before-the-pointwise-ergodic-theorem-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/birkhoff-convergence-events-deep-card.XXXXXX")"
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
  -annotate +67+138 'Birkhoff convergence events' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+181 'One finite orbit converges. One bounded deterministic shift does not.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,218 1132,506 18,18' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 94,246 530,424 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +126+281 'TWO-STATE SWAP' \
  -fill '#16243A' -stroke none -font Palatino-Roman -pointsize 30 \
  -annotate +129+329 'a: 0, 2, 0, 2, ...' \
  -annotate +129+367 'b: 2, 0, 2, 0, ...' \
  -fill '#47633B' -font Helvetica-Bold -pointsize 18 \
  -annotate +129+405 'both average sequences converge to 1' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 558,246 1106,424 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +592+281 'BOUNDED DECIMAL-BLOCK SHIFT' \
  -fill '#16243A' -font Helvetica -pointsize 18 \
  -annotate +592+327 'endpoint averages:  9/10,  9/100' \
  -annotate +592+361 '                         909/1000,  909/10000' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 18 \
  -annotate +592+405 'subsequence limits: 10/11 and 1/11' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 94,444 1106,487 11,11' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +127+472 'EXACT PREFIX INVARIANCE  =>  NULL OR CONULL; A MEMBERSHIP THEOREM CHOOSES THE BRANCH' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'FINITE LEDGER  /  MEASURABLE EVENT  /  SAME-LIMIT SHIFT  /  CONDITIONAL RIGIDITY' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "birkhoff-convergence-events-before-the-pointwise-ergodic-theorem-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified birkhoff-convergence-events-before-the-pointwise-ergodic-theorem-card.png"
fi
