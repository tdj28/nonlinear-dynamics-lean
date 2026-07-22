#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/limit-superior-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/limit-superior-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 20 \
  -annotate +68+78 'KNOWLEDGE BASE / GLOSSARY' \
  -fill '#16243A' -font Palatino-Roman -pointsize 55 \
  -annotate +67+165 'Limit superior' \
  -fill '#4D5B6B' -font Helvetica -pointsize 19 \
  -annotate +70+229 'The eventual upper edge of a sequence.' \
  -annotate +70+259 'Finite prefixes no longer matter.' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 66,330 566,441 16,16' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +104+370 'UPPER LIMSUP ONLY' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +104+403 'A limsup bound does not force' \
  -annotate +104+426 'convergence or a matching lower edge.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 632,70 1136,486 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 674,106 1094,340 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +793+137 'OSCILLATING TAIL' \
  -fill none -stroke '#4B6787' -strokewidth 3 \
  -draw 'polyline 704,290 742,168 780,302 818,190 856,310 894,210 932,316 970,228 1008,320 1050,244' \
  -fill none -stroke '#A67C52' -strokewidth 2 \
  -draw 'line 704,155 796,155 line 806,178 908,178 line 918,202 1050,202' \
  -fill '#4D5B6B' -stroke none -font Helvetica -pointsize 12 \
  -annotate +704+326 'TAIL CEILINGS DESCEND AS THE PREFIX IS DISCARDED' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,346 884,364 polygon 877,357 891,357 884,368' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 674,376 1094,444 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +781+404 'EVENTUAL UPPER LEVEL' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +776+428 'UPPER EDGE, NOT CONVERGENCE' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+580 'TAIL CEILINGS  /  EVENTUAL UPPER EDGE  /  FINITE PREFIX IGNORED  /  NOT CONVERGENCE' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "limit-superior-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified limit-superior-card.png"
fi
