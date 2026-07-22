#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/identifying-the-finite-measure-birkhoff-limit-in-lean-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/identified-birkhoff-limit-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 16 \
  -annotate +68+78 'DEVELOPMENT NOTEBOOK / IDENTIFIED BIRKHOFF LIMIT' \
  -fill '#16243A' -font Palatino-Roman -pointsize 48 \
  -annotate +67+151 'What do time' \
  -annotate +67+209 'averages remember?' \
  -fill '#4D5B6B' -font Helvetica -pointsize 19 \
  -annotate +70+270 'They converge to the observable' \
  -annotate +70+298 'seen through invariant information.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 66,346 568,446 16,16' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +104+380 'THE LIMIT IS IDENTIFIED' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +104+408 'Conditional expectation on the exact' \
  -annotate +104+429 'invariant sigma algebra.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 638,62 1134,506 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 682,96 1090,170 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +802+128 'ORBIT AVERAGES' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +794+151 'CONVERGE ALMOST EVERYWHERE' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 886,176 886,208 polygon 879,201 893,201 886,212' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 682,220 1090,300 14,14' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +773+253 'ABSOLUTE-MEAN BRIDGE' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +794+278 'INVARIANT SET INTEGRALS' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 886,306 886,338 polygon 879,331 893,331 886,342' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 682,350 1090,454 14,14' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +753+386 'CONDITIONAL EXPECTATION' \
  -fill '#315F55' -font Helvetica -pointsize 14 \
  -annotate +775+414 'the observable seen invariantly' \
  -fill '#FFFDF8' -font Helvetica -pointsize 15 \
  -annotate +68+580 'FINITE MEASURE  /  NO ERGODICITY  /  NO INVERTIBILITY  /  ALMOST EVERYWHERE' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "identifying-the-finite-measure-birkhoff-limit-in-lean-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified identifying-the-finite-measure-birkhoff-limit-in-lean-card.png"
fi
