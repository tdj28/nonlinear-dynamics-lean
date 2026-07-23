#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/guarded-real-liminf-bridge-to-log-positive-kingman-convergence-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt33-deep-dive-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,20 rectangle 0,552 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 18 \
  -annotate +64+68 'KNOWLEDGE BASE / DEEP DIVE' \
  -fill '#16243A' -font Palatino-Bold -pointsize 34 \
  -annotate +63+120 'The guarded real-liminf bridge' \
  -annotate +63+161 'to log-positive Kingman convergence' \
  -fill '#4D5B6B' -font Helvetica -pointsize 16 \
  -annotate +66+202 'Three exact sequences show where rational slack works - and where the guard fails.' \
  -fill '#FBF9F6' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 62,236 400,482 16,16' \
  -fill '#EAF1E5' -stroke none \
  -draw 'roundrectangle 83,256 223,285 14,14' \
  -fill '#315F55' -font Helvetica-Bold -pointsize 13 \
  -annotate +101+276 'GUARD PRESENT' \
  -fill '#16243A' -font Palatino-Bold -pointsize 21 \
  -annotate +84+320 'BOUNDED ALTERNATION' \
  -fill '#4D5B6B' -font Courier -pointsize 15 \
  -annotate +84+354 '0, -3/2, -1/2, -3/2, ...' \
  -fill '#8B6440' -font Helvetica -pointsize 14 \
  -annotate +84+386 'inner q=-5/4 < target c=-1' \
  -fill '#315F55' -font Helvetica-Bold -pointsize 14 \
  -annotate +84+421 'guard + event -> liminf=-3/2' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +84+452 'the honest bounded-below regime' \
  -fill '#FBF9F6' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 431,236 769,482 16,16' \
  -fill '#F3E8E0' -stroke none \
  -draw 'roundrectangle 452,256 598,285 14,14' \
  -fill '#8B3E33' -font Helvetica-Bold -pointsize 13 \
  -annotate +470+276 'STRICTNESS TEST' \
  -fill '#16243A' -font Palatino-Bold -pointsize 21 \
  -annotate +453+320 'APPROACH ZERO' \
  -fill '#4D5B6B' -font Courier -pointsize 15 \
  -annotate +453+354 '0, -1, -1/2, -1/3, ...' \
  -fill '#8B6440' -font Helvetica -pointsize 14 \
  -annotate +453+386 'sequence a_n < target c=0 for every n > 0' \
  -fill '#8B3E33' -font Helvetica-Bold -pointsize 14 \
  -annotate +453+421 'no fixed inner q < 0 recurs' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +453+452 'target crossing is not slack' \
  -fill '#FBF9F6' -stroke '#8B3E33' -strokewidth 2 \
  -draw 'roundrectangle 800,236 1138,482 16,16' \
  -fill '#F3E8E0' -stroke none \
  -draw 'roundrectangle 821,256 957,285 14,14' \
  -fill '#8B3E33' -font Helvetica-Bold -pointsize 13 \
  -annotate +839+276 'GUARD MISSING' \
  -fill '#16243A' -font Palatino-Bold -pointsize 21 \
  -annotate +822+320 'QUADRATIC ESCAPE' \
  -fill '#4D5B6B' -font Courier -pointsize 15 \
  -annotate +822+354 '0, 0, -1, -2, -3, ...' \
  -fill '#8B6440' -font Helvetica -pointsize 14 \
  -annotate +822+386 'inner q=-2 < target c=-1 recurs' \
  -fill '#8B3E33' -font Helvetica-Bold -pointsize 14 \
  -annotate +822+421 'total real liminf=0' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +822+452 'event true; unguarded result false' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 178,504 1022,539 12,12' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +208+527 'LOWER LIMINF RAIL + UPPER LIMSUP RAIL -> CONVERGENCE TO THE LOG-POSITIVE RATE' \
  -fill '#FFFDF8' -font Helvetica-Bold -pointsize 14 \
  -annotate +64+584 'NONNEGATIVE LOG-POSITIVE ENVELOPE ONLY' \
  -fill '#C7D2DF' -font Helvetica -pointsize 13 \
  -annotate +64+609 'Signed contraction, integral convergence, and invariant splittings remain out of scope.' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "guarded-real-liminf-bridge-to-log-positive-kingman-convergence-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified guarded-real-liminf-bridge-to-log-positive-kingman-convergence-card.png"
fi
