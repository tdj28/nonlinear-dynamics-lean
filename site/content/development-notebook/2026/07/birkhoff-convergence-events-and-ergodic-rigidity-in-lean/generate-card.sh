#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/birkhoff-convergence-events-and-ergodic-rigidity-in-lean-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/birkhoff-convergence-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / BIRKHOFF CONVERGENCE EVENTS' \
  -fill '#16243A' -font Palatino-Roman -pointsize 52 \
  -annotate +67+145 'Convergence without existence' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+188 'Finite-prefix invariance makes the event rigid, conditionally.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,226 745,490 18,18' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +96+263 'DELETE ONE ORBIT PREFIX' \
  -fill none -stroke '#7F786D' -strokewidth 3 \
  -draw 'line 110,335 704,335 line 110,323 110,347 line 704,323 704,347' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 126,294 242,376 10,10' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 268,294 386,376 10,10 roundrectangle 412,294 530,376 10,10 roundrectangle 556,294 674,376 10,10' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +148+326 'PREFIX' \
  -fill '#284E72' -font Helvetica-Bold -pointsize 14 \
  -annotate +301+326 'TAIL' -annotate +445+326 'TAIL' -annotate +589+326 'TAIL' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +116+413 'add or delete one finite term' \
  -fill '#6F8D5E' -font Helvetica-Bold -pointsize 16 \
  -annotate +409+413 'SAME FINITE LIMIT' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +124+457 'no boundedness or invertibility required' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 790,226 1132,292 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +820+253 'MEASURABLE EVENT' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +820+276 'or null-measurable representative' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 961,299 961,323' \
  -fill '#A67C52' -stroke none \
  -draw 'polygon 961,335 953,320 969,320' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 790,335 1132,401 14,14' \
  -fill '#527044' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +823+362 'EXACTLY INVARIANT' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +823+385 'under preimage by the base map' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 961,408 961,432' \
  -fill '#A67C52' -stroke none \
  -draw 'polygon 961,444 953,429 969,429' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 790,444 1132,490 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +848+473 'NULL OR CONULL' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+579 'CONDITIONAL RIGIDITY  /  NO CONVERGENCE-EXISTENCE THEOREM' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "birkhoff-convergence-events-and-ergodic-rigidity-in-lean-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified birkhoff-convergence-events-and-ergodic-rigidity-in-lean-card.png"
fi
