#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/identifying-the-ergodic-birkhoff-constant-in-lean-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/ergodic-birkhoff-constant-card.XXXXXX")"
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
  -annotate +68+78 'DEVELOPMENT NOTEBOOK / ERGODIC BIRKHOFF CONSTANT' \
  -fill '#16243A' -font Palatino-Roman -pointsize 46 \
  -annotate +67+151 'Why does the limit' \
  -annotate +67+207 'become one number?' \
  -fill '#4D5B6B' -font Helvetica -pointsize 19 \
  -annotate +70+264 'Invariant-set rigidity makes the limit constant.' \
  -annotate +70+293 'Positive mass identifies the normalized average.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 66,346 566,448 16,16' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +104+381 'THE CONSTANT IS IDENTIFIED' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +104+410 'Finite positive mass gives the' \
  -annotate +104+431 'normalized space average.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 638,62 1134,506 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 682,96 1090,170 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +785+128 'INVARIANT LIMIT' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +777+151 'EXACTLY UNCHANGED BY ONE STEP' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 886,176 886,208 polygon 879,201 893,201 886,212' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 682,220 1090,300 14,14' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +770+253 'INVARIANT-SET RIGIDITY' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +802+278 'ONE VALUE ALMOST EVERYWHERE' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 886,306 886,338 polygon 879,331 893,331 886,342' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 682,350 1090,454 14,14' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +755+386 'NORMALIZED SPACE AVERAGE' \
  -fill '#315F55' -font Helvetica -pointsize 14 \
  -annotate +786+414 'ordinary integral for probability' \
  -fill '#FFFDF8' -font Helvetica -pointsize 15 \
  -annotate +68+580 'FINITE POSITIVE MASS  /  ERGODIC DYNAMICS  /  LEAN CHECKED  /  NO INVERSE' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "identifying-the-ergodic-birkhoff-constant-in-lean-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified identifying-the-ergodic-birkhoff-constant-in-lean-card.png"
fi
