#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt34-deep-dive-card.XXXXXX")"
  verify=true
  trap 'rm -f "$output"' EXIT HUP INT TERM
elif test "$#" -gt 0; then
  output="$1"
else
  output="$checked"
fi

magick -size 1200x630 xc:'#F7F4F0' \
  -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,542 1200,630' \
  -fill '#A67C52' -font Helvetica-Bold -pointsize 18 \
  -annotate +68+76 'KNOWLEDGE BASE / DEEP DIVE' \
  -fill '#16243A' -font Palatino-Roman -pointsize 34 \
  -annotate +67+132 'The forward-and-inverse tail sandwich' \
  -annotate +67+174 'for finite-time real log norms' \
  -fill '#4D5B6B' -font Helvetica -pointsize 16 \
  -annotate +70+215 'Two integrable rails turn signed finite-time growth into a reusable candidate.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 66,252 1134,507 18,18' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 89,282 326,474 14,14' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +119+321 'THREE INPUTS' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +119+358 'pointwise units' \
  -annotate +119+387 'forward generator moment' \
  -annotate +119+416 'inverse generator moment' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 338,378 386,378 polygon 386,378 372,369 372,387' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 398,279 787,338 12,12' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +475+315 'FORWARD POSITIVE-LOG UPPER RAIL' \
  -fill '#FFFDF8' -stroke '#8B3E33' -strokewidth 3 \
  -draw 'roundrectangle 431,349 754,407 12,12' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +505+385 'FINITE-TIME REAL LOG' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 398,418 787,477 12,12' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 14 \
  -annotate +474+454 'INVERSE-ORBIT LOWER RAIL' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 799,378 847,378 polygon 847,378 833,369 833,387' \
  -fill '#16243A' -stroke '#16243A' -strokewidth 2 \
  -draw 'roundrectangle 859,282 1111,474 14,14' \
  -fill '#FFFFFF' -stroke none -font Helvetica-Bold -pointsize 15 \
  -annotate +897+321 'CHECKED OUTPUT' \
  -fill '#E8F0F7' -font Helvetica -pointsize 13 \
  -annotate +897+358 'integrable signed slices' \
  -annotate +897+387 'shifted subadditivity' \
  -annotate +897+416 'finite-time candidate' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'FINITE-TIME INFRASTRUCTURE  /  STRICT POSITIVE-RATE SHORTCUT IS A SEPARATE ROUTE' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms-card.png"
fi
