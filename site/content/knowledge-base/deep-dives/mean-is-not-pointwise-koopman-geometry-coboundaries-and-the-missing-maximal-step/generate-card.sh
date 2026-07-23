#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/mean-is-not-pointwise-koopman-geometry-coboundaries-and-the-missing-maximal-step-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/koopman-mean-pointwise-deep-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 46 \
  -annotate +67+140 'Mean is not pointwise' \
  -fill '#4D5B6B' -font Helvetica -pointsize 19 \
  -annotate +70+181 'One exact two-state calculation; one exact logical boundary' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,211 703,510 18,18 roundrectangle 727,211 1132,510 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +94+244 'THE TWO-STATE LEDGER' \
  -fill '#DCEAF0' -stroke '#315A70' -strokewidth 3 \
  -draw 'circle 157,304 157,266' \
  -fill '#F1DFCF' -stroke '#A5532D' -strokewidth 3 \
  -draw 'circle 351,304 351,266' \
  -fill '#16243A' -stroke none -font Palatino-Roman -pointsize 24 \
  -annotate +150+312 'a' -annotate +344+312 'b' \
  -fill none -stroke '#315A70' -strokewidth 4 \
  -draw 'line 179,283 326,283 polygon 326,283 310,274 310,292' \
  -fill none -stroke '#A5532D' -strokewidth 4 \
  -draw 'line 326,325 179,325 polygon 179,325 195,316 195,334' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 14 \
  -annotate +218+274 'T swaps' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 410,262 675,344 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +439+292 'f = (1,3)' \
  -annotate +439+323 'U f = (3,1)' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 94,372 675,482 13,13' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 18 \
  -annotate +119+405 'P f = (2,2)' \
  -annotate +119+436 '(U - I)u = (-1,1),  u = (0,-1)' \
  -fill '#16243A' -font Palatino-Bold -pointsize 22 \
  -annotate +119+468 'f = P f + (U - I)u' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 17 \
  -annotate +755+244 'THE LOGICAL GAP' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 755,264 1104,326 12,12' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +795+290 'ALL L2 INPUTS' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +942+290 'mean in L2 norm' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 929,330 929,354 polygon 929,354 920,338 938,338' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 755,358 1104,420 12,12' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +781+385 'ONE A.E. SUBSEQUENCE' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +781+408 'safe generic consequence' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 929,424 929,448' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 755,452 1104,489 12,12' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +779+477 'FULL SEQUENCE NEEDS MAXIMAL CLOSURE' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'COMPUTE THE GEOMETRY  /  KEEP THE CONVERGENCE MODES SEPARATE' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "mean-is-not-pointwise card is stale; regenerate it" >&2
    exit 1
  }
  echo "verified mean-is-not-pointwise-koopman-geometry-coboundaries-and-the-missing-maximal-step-card.png"
fi
