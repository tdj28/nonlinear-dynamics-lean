#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/complex-gaussian-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/complex-gaussian-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,534 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 21 \
  -annotate +70+91 'DEVELOPMENT NOTEBOOK / COMPLEX PROBABILITY' \
  -fill '#16243A' -font Palatino-Roman -pointsize 63 \
  -annotate +68+178 'Complex Gaussian' \
  -fill '#16243A' -font Palatino-Roman -pointsize 49 \
  -annotate +70+243 'coordinates in Lean' \
  -fill '#4D5B6B' -font Helvetica -pointsize 21 \
  -annotate +72+303 'Exact laws, visible geometry, no hidden symmetry' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 716,65 1132,500 28,28' \
  -fill '#C16F2C' -stroke none -font Helvetica -pointsize 18 \
  -annotate +803+105 'CIRCULARITY NOT ASSUMED' \
  -stroke '#7F786D' -strokewidth 2 -fill none \
  -draw 'line 772,310 1087,310 line 929,150 929,452' \
  -stroke '#4B6787' -strokewidth 4 -fill none \
  -draw 'ellipse 929,310 132,74 0,360 ellipse 929,310 93,52 0,360 ellipse 929,310 54,30 0,360' \
  -fill '#284E72' -stroke none -font Helvetica -pointsize 17 \
  -annotate +973+294 'REAL SPREAD' \
  -fill '#934F1F' -font Helvetica -pointsize 17 \
  -annotate +793+177 'IMAGINARY' \
  -annotate +810+199 'SPREAD' \
  -fill '#C16F2C' -stroke none \
  -draw 'circle 929,310 935,310' \
  -fill '#5A544C' -font Helvetica -pointsize 15 \
  -annotate +744+475 'UNEQUAL VARIANCES STAY VISIBLE' \
  -fill '#284E72' -stroke '#284E72' -strokewidth 2 \
  -draw 'roundrectangle 72,365 243,463 14,14' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 17 \
  -annotate +92+404 'TWO REAL LAWS' \
  -font Helvetica -pointsize 15 -annotate +98+437 'real + imaginary' \
  -stroke '#A67C52' -strokewidth 4 -fill '#A67C52' \
  -draw 'line 255,414 299,414 polygon 299,414 284,402 284,426' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 311,365 493,463 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica -pointsize 19 \
  -annotate +337+404 'PRODUCT LAW' \
  -font Helvetica -pointsize 15 -annotate +340+437 'independent pair' \
  -stroke '#A67C52' -strokewidth 4 -fill '#A67C52' \
  -draw 'line 505,414 549,414 polygon 549,414 534,402 534,426' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 561,365 687,463 14,14' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 18 \
  -annotate +579+403 'COMPLEX' \
  -font Helvetica -pointsize 15 -annotate +579+437 'exact law' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 16 \
  -annotate +70+580 'EXACT MARGINALS  /  INDEPENDENCE  /  DEGENERACY KEPT  /  NO GUE CHOICE' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "complex-gaussian-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified complex-gaussian-card.png"
fi
