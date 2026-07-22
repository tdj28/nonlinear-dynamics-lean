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
  -fill '#16243A' -font Palatino-Roman -pointsize 46 \
  -annotate +67+138 'Before the pointwise ergodic theorem' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+181 'Build the convergence event, prove exact invariance, then stop at the honest fork.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,218 1132,506 18,18' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 96,270 330,394 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +140+305 'FINITE AVERAGES' \
  -fill '#5A544C' -stroke none -font Helvetica -pointsize 14 \
  -annotate +128+342 'measurable at every horizon' -annotate +128+368 'convergence defines an event' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 338,332 396,332 polygon 396,332 379,322 379,342' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 408,270 642,394 14,14' \
  -fill '#47633B' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +461+305 'EXACT INVARIANCE' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +441+342 'delete one finite prefix' -annotate +448+368 'keep the same finite limit' \
  -fill none -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 650,332 708,332 polygon 708,332 691,322 691,342' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 720,246 1104,316 14,14 roundrectangle 720,348 1104,418 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +842+282 'ERGODIC BRANCH: NULL' \
  -fill '#47633B' -font Helvetica-Bold -pointsize 17 \
  -annotate +830+384 'ERGODIC BRANCH: CONULL' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +785+462 'BLOCKED: invariance cannot choose the conull branch' \
  -fill none -stroke '#934F1F' -strokewidth 4 \
  -draw 'line 854,434 1070,434 line 951,423 973,445 line 973,423 951,445' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 11 \
  -annotate +96+441 'ALMOST-EVERYWHERE ROUTE' \
  -fill '#5A544C' -font Helvetica -pointsize 12 \
  -annotate +96+463 'measurable representative -> null-measurable event' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 12 \
  -annotate +96+486 'MISSING: an almost-everywhere membership theorem' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'MEASURABILITY  /  FINITE-PREFIX INVARIANCE  /  CONDITIONAL RIGIDITY' \
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
