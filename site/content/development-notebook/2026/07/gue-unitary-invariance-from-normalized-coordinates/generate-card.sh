#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/gue-unitary-invariance-from-normalized-coordinates-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/gue-unitary-invariance-from-normalized-coordinates-card.XXXXXX")"
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
  -annotate +68+76 'DEVELOPMENT NOTEBOOK / RMT-08' \
  -fill '#16243A' -font Palatino-Roman -pointsize 57 \
  -annotate +67+148 'Coordinates become symmetry' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+190 'Normalize sqrt(2). Transport the exact product law. Commute the square.' \
  -fill '#FFFDF8' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 68,225 287,310 13,13 roundrectangle 304,225 523,310 13,13 roundrectangle 540,225 759,310 13,13' \
  -fill '#4D5B6B' -stroke none -font Helvetica -pointsize 13 \
  -annotate +118+251 'REAL DIAGONAL' \
  -annotate +339+251 'UPPER REAL' \
  -annotate +569+251 'UPPER IMAGINARY' \
  -fill '#284E72' -font Palatino-Roman -pointsize 22 \
  -annotate +118+283 'd_i    var v_n' \
  -annotate +327+283 'sqrt(2) Re u_ij' \
  -annotate +561+283 'sqrt(2) Im u_ij' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 177,321 177,341 line 413,321 413,341 line 649,321 649,341 line 177,341 649,341 line 413,341 413,360 polygon 413,370 402,356 424,356' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 104,374 456,490 16,16' \
  -fill '#284E72' -stroke none -font Helvetica -pointsize 15 \
  -annotate +167+407 'ONE REAL GAUSSIAN PRODUCT' \
  -font Palatino-Roman -pointsize 25 \
  -annotate +153+448 'I_n = D + (T + T)' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +175+475 'common variance v_n' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 469,431 520,431 polygon 533,431 517,419 517,443' \
  -fill '#A67C52' -stroke none -font Helvetica -pointsize 11 \
  -annotate +472+414 'ISOMETRY' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 538,374 790,490 16,16' \
  -fill '#315F55' -stroke none -font Helvetica -pointsize 14 \
  -annotate +574+407 'INTRINSIC HERMITIAN LAW' \
  -font Palatino-Roman -pointsize 24 \
  -annotate +574+447 'sqrt(v_n) x Gaussian' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +587+475 'unitary congruence invariant' \
  -fill '#A67C52' -stroke '#A67C52' -strokewidth 4 \
  -draw 'line 803,431 842,431 polygon 855,431 839,419 839,443' \
  -fill '#A67C52' -stroke none -font Helvetica -pointsize 11 \
  -annotate +802+414 'INCLUDE' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 860,214 1133,490 19,19' \
  -fill '#934F1F' -stroke none -font Helvetica -pointsize 15 \
  -annotate +906+251 'AMBIENT GUE LAW' \
  -font Palatino-Roman -pointsize 30 \
  -annotate +897+303 'H -> U H U*' \
  -font Palatino-Roman -pointsize 28 \
  -annotate +912+347 'law unchanged' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 903,380 1090,454 12,12' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +949+409 'CHECKED' \
  -font Helvetica -pointsize 13 \
  -annotate +940+438 'ALL n, INCLUDING 0' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+582 'FACTOR TWO  /  EXACT PRODUCT TRANSPORT  /  COMMUTING SQUARE  /  NO DENSITY OR JACOBIAN' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "gue-unitary-invariance-from-normalized-coordinates-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified gue-unitary-invariance-from-normalized-coordinates-card.png"
fi
