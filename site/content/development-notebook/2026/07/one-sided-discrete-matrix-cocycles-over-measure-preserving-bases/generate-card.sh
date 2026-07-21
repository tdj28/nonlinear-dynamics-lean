#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/one-sided-discrete-matrix-cocycles-over-measure-preserving-bases-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/one-sided-matrix-cocycle-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / DISCRETE MATRIX COCYCLES' \
  -fill '#16243A' -font Palatino-Roman -pointsize 50 \
  -annotate +67+145 'One generator, an exact cocycle' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Advance the base. Observe one rule. Split time without reversing action.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 68,226 382,490 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +137+263 'ADVANCE THE BASE' \
  -fill '#FFFDF8' -stroke '#4B6787' -strokewidth 1.5 \
  -draw 'roundrectangle 98,307 162,362 10,10 roundrectangle 193,307 257,362 10,10 roundrectangle 288,307 352,362 10,10' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +113+340 'START' -annotate +209+340 'NEXT' -annotate +303+340 'LATER' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 2.5 \
  -draw 'line 165,334 185,334 polygon 191,334 181,328 181,340 line 260,334 280,334 polygon 286,334 276,328 276,340' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 14 \
  -annotate +111+405 'natural iterates move forward' \
  -annotate +119+437 'no inverse is required' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 444,226 756,490 18,18' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +513+263 'OBSERVE A MATRIX' \
  -fill '#FFFDF8' -stroke '#A67C52' -strokewidth 1.5 \
  -draw 'roundrectangle 482,302 718,372 11,11 roundrectangle 482,398 718,456 11,11' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +534+331 'SAME GENERATOR' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +520+355 'at every visited environment' \
  -fill '#5A544C' -font Helvetica-Bold -pointsize 16 \
  -annotate +535+426 'FINITE VALUE' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +521+449 'newest observation on the left' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 818,226 1132,490 18,18' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +890+263 'SPLIT TIME EXACTLY' \
  -fill '#FFFDF8' -stroke '#6F8D5E' -strokewidth 1.5 \
  -draw 'roundrectangle 854,302 1096,372 11,11 roundrectangle 854,398 1096,456 11,11' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +911+331 'EARLIER PREFIX' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +914+355 'acts first on the right' \
  -fill '#315F55' -font Helvetica-Bold -pointsize 16 \
  -annotate +918+426 'LATER BLOCK' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +885+449 'shifted base point, written left' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'ONE-SIDED FINITE TIME  /  MEASURE-PRESERVING BASE  /  NO LYAPUNOV CLAIM' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "one-sided-discrete-matrix-cocycles-over-measure-preserving-bases-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified one-sided-discrete-matrix-cocycles-over-measure-preserving-bases-card.png"
fi
