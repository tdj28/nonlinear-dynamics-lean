#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/hermitian-coordinate-assembly-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/hermitian-coordinate-assembly-card.XXXXXX")"
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
  -annotate +70+91 'DEVELOPMENT NOTEBOOK / HERMITIAN GEOMETRY' \
  -fill '#16243A' -font Palatino-Roman -pointsize 58 \
  -annotate +68+170 'Hermitian coordinate' \
  -fill '#16243A' -font Palatino-Roman -pointsize 55 \
  -annotate +70+235 'assembly' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +72+291 'Choose half the matrix. Conjugate reflection determines the rest.' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 72,335 312,400 13,13' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 17 \
  -annotate +104+363 'REAL DIAGONAL' \
  -font Helvetica -pointsize 14 -annotate +130+387 'd0  d1  d2' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 72,424 312,489 13,13' \
  -fill '#284E72' -stroke none -font Helvetica -pointsize 17 \
  -annotate +90+452 'COMPLEX STRICT UPPER' \
  -font Helvetica -pointsize 14 -annotate +113+476 'u01  u02  u12' \
  -stroke '#A67C52' -strokewidth 4 -fill none \
  -draw 'line 325,367 374,367 line 374,367 399,411 line 325,456 374,456 line 374,456 399,411' \
  -fill '#A67C52' -stroke '#A67C52' \
  -draw 'line 399,411 427,411 polygon 438,411 422,399 422,423' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 440,364 650,458 14,14' \
  -fill '#934F1F' -stroke none -font Helvetica -pointsize 17 \
  -annotate +470+402 'DIRECT ASSEMBLY' \
  -font Helvetica -pointsize 14 -annotate +484+431 'three index regions' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 663,411 708,411 polygon 720,411 704,399 704,423' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 724,65 1132,505 28,28' \
  -fill '#C16F2C' -stroke none -font Helvetica -pointsize 18 \
  -annotate +822+105 'HERMITIAN OUTPUT' \
  -fill '#5A544C' -font Helvetica -pointsize 14 \
  -annotate +789+132 'upper supplied  /  lower reflected' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 765,164 860,249 8,8 roundrectangle 875,274 970,359 8,8 roundrectangle 985,384 1080,469 8,8' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 875,164 970,249 8,8 roundrectangle 985,164 1080,249 8,8 roundrectangle 985,274 1080,359 8,8' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 765,274 860,359 8,8 roundrectangle 765,384 860,469 8,8 roundrectangle 875,384 970,469 8,8' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 18 \
  -annotate +800+214 'd0' -annotate +910+324 'd1' -annotate +1020+434 'd2' \
  -fill '#284E72' -font Helvetica -pointsize 16 \
  -annotate +907+214 'u01' -annotate +1017+214 'u02' -annotate +1017+324 'u12' \
  -fill '#934F1F' -font Helvetica -pointsize 14 \
  -annotate +783+324 'conj u01' -annotate +783+434 'conj u02' -annotate +893+434 'conj u12' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 16 \
  -annotate +70+580 'DIRECT INSERTION  /  CONJUGATE REFLECTION  /  ZERO DIMENSION  /  NO GUE CHOICE' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "hermitian-coordinate-assembly-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified hermitian-coordinate-assembly-card.png"
fi
