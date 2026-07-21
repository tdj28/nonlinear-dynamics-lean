#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/gue-frobenius-geometry-and-hermitian-support-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/gue-frobenius-geometry-and-hermitian-support-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F3EFE6' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,536 1200,630' \
  -fill '#C16F2C' -font Helvetica -pointsize 20 \
  -annotate +70+78 'DEVELOPMENT NOTEBOOK / GUE GEOMETRY' \
  -fill '#16243A' -font Palatino-Roman -pointsize 58 \
  -annotate +68+151 'The geometry behind GUE' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +72+193 'Flatten matrices. Isolate Hermitian space. Rotate without distortion.' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 70,230 318,346 16,16' \
  -fill '#4D5B6B' -stroke none -font Helvetica -pointsize 14 \
  -annotate +108+263 'AMBIENT COMPLEX MATRIX' \
  -fill '#284E72' -font Palatino-Roman -pointsize 28 \
  -annotate +128+305 'X = [ xij ]' \
  -fill '#6D7783' -font Helvetica -pointsize 13 \
  -annotate +121+329 'entrywise measurable' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 331,288 370,288 polygon 383,288 367,276 367,300' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 387,230 641,346 16,16' \
  -fill '#284E72' -stroke none -font Helvetica -pointsize 14 \
  -annotate +424+263 'FROBENIUS EUCLIDEAN' \
  -font Palatino-Roman -pointsize 28 \
  -annotate +428+305 'C^(n x n)' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +439+329 'inner = Tr(X* Y)' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 654,288 693,288 polygon 706,288 690,276 690,300' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 710,217 1128,359 18,18' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 14 \
  -annotate +787+252 'INTRINSIC REAL HERMITIAN SPACE' \
  -font Palatino-Roman -pointsize 29 \
  -annotate +780+297 'H = H*     H -> U H U*' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +797+330 'real linear / length preserved' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 70,385 486,503 16,16' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 15 \
  -annotate +119+420 'INTRINSIC STANDARD GAUSSIAN' \
  -font Palatino-Roman -pointsize 30 \
  -annotate +149+462 'invariant under U H U*' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 530,385 922,503 16,16' \
  -fill '#934F1F' -stroke none -font Helvetica -pointsize 15 \
  -annotate +587+420 'AMBIENT COORDINATE GUE LAW' \
  -font Palatino-Roman -pointsize 30 \
  -annotate +601+462 'Hermitian mass = 1' \
  -fill '#FFF8E8' -stroke '#C16F2C' -strokewidth 2 \
  -draw 'roundrectangle 949,385 1128,503 16,16' \
  -fill '#C16F2C' -stroke none -font Helvetica -pointsize 14 \
  -annotate +978+424 'NORMALIZED' \
  -annotate +986+449 'LAW BRIDGE' \
  -font Helvetica-Bold -pointsize 17 \
  -annotate +994+480 'STILL OPEN' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 16 \
  -annotate +70+581 'FROBENIUS TRACE  /  REAL SUBSPACE  /  UNITARY ISOMETRY  /  TWO DISTINCT MEASURES' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "gue-frobenius-geometry-and-hermitian-support-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified gue-frobenius-geometry-and-hermitian-support-card.png"
fi
