#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/koopman-l2-mean-convergence-and-a-dense-pointwise-good-core-in-lean-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/koopman-l2-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -stroke none \
  -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 20 \
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / SQUARE-INTEGRABLE ERGODIC AVERAGES' \
  -fill '#16243A' -font Palatino-Roman -pointsize 50 \
  -annotate +67+145 'Mean convergence is not pointwise' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Koopman geometry finds the limit; coboundaries build a dense pointwise-good core.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,226 1132,490 18,18' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 96,266 346,382 12,12' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +126+300 'KOOPMAN OPERATOR' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +126+332 'composition on square-integrable functions' \
  -annotate +126+356 'a contraction under measure preservation' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 364,324 438,324' \
  -fill '#A67C52' -stroke none \
  -draw 'polygon 454,324 436,315 436,333' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 454,266 704,382 12,12' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +488+300 'HILBERT MEAN LIMIT' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +488+332 'orthogonal projection onto fixed vectors' \
  -annotate +488+356 'norm, then measure, then a subsequence' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 722,324 796,324' \
  -fill '#A67C52' -stroke none \
  -draw 'polygon 812,324 794,315 794,333' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 812,266 1104,382 12,12' \
  -fill '#527044' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +844+300 'DENSE GOOD CORE' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +844+332 'fixed vectors plus simple coboundaries' \
  -annotate +844+356 'full averages converge almost everywhere' \
  -fill '#284E72' -font Helvetica-Bold -pointsize 14 \
  -annotate +98+427 'PROVED:' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +176+427 'square-integrable mean convergence and a dense pointwise-good class' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 14 \
  -annotate +98+460 'STILL MISSING:' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +228+460 'the maximal closure step for every integrable observable' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+579 'NO FINITE MASS  /  NO ERGODICITY  /  NO FULL POINTWISE THEOREM' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "koopman-l2-mean-convergence-and-a-dense-pointwise-good-core-in-lean-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified koopman-l2-mean-convergence-and-a-dense-pointwise-good-core-in-lean-card.png"
fi
