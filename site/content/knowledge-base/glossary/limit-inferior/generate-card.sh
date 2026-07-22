#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/limit-inferior-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/limit-inferior-card.XXXXXX")"
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
  -annotate +67+165 'Limit inferior' \
  -fill '#4D5B6B' -font Helvetica -pointsize 19 \
  -annotate +70+229 'The eventual lower edge of a sequence.' \
  -annotate +70+259 'Finite prefixes no longer matter.' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 66,330 566,441 16,16' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 17 \
  -annotate +104+370 'LOWER LIMINF ONLY' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +104+403 'A liminf bound does not force' \
  -annotate +104+426 'convergence or a matching upper edge.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 632,70 1136,486 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 674,106 1094,340 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +809+137 'OSCILLATING TAIL' \
  -fill none -stroke '#4B6787' -strokewidth 3 \
  -draw 'polyline 704,168 742,300 780,184 818,286 856,202 894,272 932,218 970,258 1008,232 1050,246' \
  -fill none -stroke '#A67C52' -strokewidth 2 \
  -draw 'line 704,314 796,314 line 806,288 908,288 line 918,260 1050,260' \
  -fill '#4D5B6B' -stroke none -font Helvetica -pointsize 12 \
  -annotate +708+332 'TAIL FLOORS RISE AS THE PREFIX IS DISCARDED' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 884,346 884,364 polygon 877,357 891,357 884,368' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 674,376 1094,444 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +787+404 'EVENTUAL LOWER LEVEL' \
  -fill '#4D5B6B' -font Helvetica -pointsize 13 \
  -annotate +773+428 'LOWER EDGE, NOT CONVERGENCE' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 15 \
  -annotate +68+580 'TAIL FLOORS  /  EVENTUAL LOWER EDGE  /  FINITE PREFIX IGNORED  /  NOT CONVERGENCE' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "limit-inferior-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified limit-inferior-card.png"
fi
