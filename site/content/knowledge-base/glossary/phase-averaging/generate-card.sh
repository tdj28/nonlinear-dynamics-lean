#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/phase-averaging-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'KNOWLEDGE BASE / RANDOM DYNAMICS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 48 \
    -annotate +72+164 'Phase averaging' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+220 'Collect fixed-block estimates from every residue phase.' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 72,286 574,356 14,14' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 18 \
    -annotate +112+329 'BOUNDARY GAPS NEED A POSITIVE-TIME SIGN' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 72,382 574,452 14,14' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 19 \
    -annotate +123+425 'ZERO BLOCK LENGTH IS VACUOUS' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 658,64 1132,480 22,22' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
    -annotate +810+99 'START POSITIONS BY PHASE' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 708,120 820,164 9,9 roundrectangle 842,120 954,164 9,9 roundrectangle 976,120 1088,164 9,9 roundrectangle 708,178 820,222 9,9 roundrectangle 842,178 954,222 9,9 roundrectangle 976,178 1088,222 9,9 roundrectangle 708,236 820,280 9,9 roundrectangle 842,236 954,280 9,9 roundrectangle 976,236 1088,280 9,9 roundrectangle 708,294 820,338 9,9 roundrectangle 842,294 954,338 9,9 roundrectangle 976,294 1088,338 9,9' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 18 \
    -annotate +758+149 '0' -annotate +892+149 '4' -annotate +1026+149 '8' \
    -annotate +758+207 '1' -annotate +892+207 '5' -annotate +1026+207 '9' \
    -annotate +758+265 '2' -annotate +892+265 '6' -annotate +1020+265 '10' \
    -annotate +758+323 '3' -annotate +892+323 '7' -annotate +1020+323 '11' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 898,346 898,372 polygon 891,365 905,365 898,376' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 708,386 1088,450 13,13' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 18 \
    -annotate +772+425 'TWELVE CONSECUTIVE STARTS' \
    -fill '#FFFDF8' -font Helvetica -pointsize 17 \
    -annotate +72+578 'EXACT REINDEXING  /  POSITIVE-TIME SIGN  /  NO LIMIT THEOREM' \
    -strip -define png:exclude-chunk=date,time \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/phase-averaging-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "phase-averaging-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified phase-averaging-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
