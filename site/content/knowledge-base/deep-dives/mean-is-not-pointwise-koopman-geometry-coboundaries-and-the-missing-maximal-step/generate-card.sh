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
  -fill '#16243A' -font Palatino-Roman -pointsize 48 \
  -annotate +67+140 'Mean is not pointwise' \
  -fill '#4D5B6B' -font Helvetica -pointsize 19 \
  -annotate +70+181 'Koopman geometry, coboundaries, and the missing maximal step' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,216 1132,510 18,18' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 94,251 353,348 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +137+283 'ALL REAL L2 INPUTS' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +121+313 'Koopman operator averages' \
  -annotate +129+334 'converge in L2 norm' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 366,300 438,300 polygon 438,300 420,289 420,311' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 450,241 741,358 14,14' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +492+276 'FIXED-SPACE PROJECTION' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +486+309 'norm -> measure -> one' \
  -annotate +468+331 'almost-everywhere subsequence' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 754,300 820,300' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 832,241 1106,358 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +861+276 'FULL POINTWISE?' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +860+309 'not from norm convergence' \
  -annotate +872+331 'maximal step missing' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 94,391 478,476 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +134+423 'FIXED + SIMPLE COBOUNDARIES' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +136+445 'dense, full-sequence pointwise-good' \
  -annotate +225+465 'almost everywhere' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 492,433 570,433 polygon 570,433 552,422 552,444' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 582,391 1106,476 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +628+423 'DENSITY NEEDS MAXIMAL STABILITY TO CLOSE' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +684+451 'planned finite-measure L1 bridge in RMT-26' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'L2 MEAN  /  DENSE POINTWISE CORE  /  FULL SEQUENCE STILL OPEN' \
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
