#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/finite-hopf-maximal-ergodic-lemma-in-lean-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/finite-hopf-maximal-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / FINITE MAXIMAL ERGODIC LEMMA' \
  -fill '#16243A' -font Palatino-Roman -pointsize 52 \
  -annotate +67+145 'Peel the positive maximum' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'A finite orbit inequality becomes a nonnegative event integral.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,226 720,490 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +96+263 'POSITIVE MAXIMIZING PREFIX' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 98,294 252,370 10,10' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +126+323 'FIRST VALUE' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +125+350 'peel from prefix' \
  -fill '#16243A' -font Helvetica-Bold -pointsize 22 \
  -annotate +275+339 '+' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 310,294 494,370 10,10' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +337+323 'SHIFTED PREFIX' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +344+350 'same orbit tail' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 506,332 550,332' \
  -fill '#A67C52' -stroke none \
  -draw 'polygon 564,332 548,324 548,340' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 564,294 690,370 10,10' \
  -fill '#527044' -stroke none -font Helvetica-Bold -pointsize 13 \
  -annotate +580+323 'SHIFTED' -annotate +575+346 'MAXIMUM' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +100+414 'strict positivity rules out time zero' \
  -fill '#6F8D5E' -font Helvetica-Bold -pointsize 15 \
  -annotate +100+452 'POINTWISE INDICATOR BOUND' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 764,226 1132,294 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +797+254 'INTEGRATE THE BOUND' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +797+278 'integrable maximum and indicator' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 948,301 948,329' \
  -fill '#A67C52' -stroke none \
  -draw 'polygon 948,341 940,326 956,326' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 764,341 1132,409 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +798+369 'PRESERVATION CANCELS' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +798+393 'current and shifted maximal integrals' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 948,416 948,440' \
  -fill '#A67C52' -stroke none \
  -draw 'polygon 948,452 940,437 956,437' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 764,452 1132,490 14,14' \
  -fill '#527044' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +805+477 'EVENT INTEGRAL NONNEGATIVE' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+579 'FINITE HORIZON  /  NO POINTWISE CONVERGENCE THEOREM' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "finite-hopf-maximal-ergodic-lemma-in-lean-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified finite-hopf-maximal-ergodic-lemma-in-lean-card.png"
fi
