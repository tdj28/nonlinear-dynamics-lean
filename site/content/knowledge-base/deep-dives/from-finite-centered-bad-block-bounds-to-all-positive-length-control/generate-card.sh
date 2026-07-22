#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/from-finite-centered-bad-block-bounds-to-all-positive-length-control-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/rmt31-deep-dive-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 37 \
  -annotate +67+137 'From finite centered bad-block bounds' \
  -annotate +67+183 'to all-positive-length control' \
  -fill '#4D5B6B' -font Helvetica -pointsize 17 \
  -annotate +70+226 'Nest finite caps. Take extended measure first. Project only at a finite target.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 66,270 1134,500 18,18' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 92,304 294,420 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +132+340 'FINITE CAPS' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +116+371 'one finite witness' \
  -annotate +114+395 'uniform ratio bound' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 304,362 352,362 polygon 352,362 338,353 338,371' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 364,290 578,434 14,14' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +404+330 'EXACT UNION' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +391+362 'extended measure limit' \
  -annotate +391+386 'finite or infinite target' \
  -fill '#934F1F' -font Helvetica-Bold -pointsize 11 \
  -annotate +393+414 'REAL VIEW NEEDS FINITENESS' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 588,362 636,362 polygon 636,362 622,353 622,371' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 648,304 850,420 14,14' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +687+340 'REAL LIMIT' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +678+371 'finite total measure' \
  -annotate +677+395 'closed-order transfer' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 860,362 908,362 polygon 908,362 894,353 894,371' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 920,290 1108,434 14,14' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +952+330 'ALL LENGTHS' \
  -fill '#5A544C' -font Helvetica -pointsize 13 \
  -annotate +946+362 'same ratio ceiling' \
  -fill '#8B3E33' -font Helvetica-Bold -pointsize 12 \
  -annotate +949+394 'NOT INVARIANT' \
  -annotate +948+414 'NO LOWER LIMINF' \
  -fill '#FFFDF8' -stroke none -font Helvetica -pointsize 14 \
  -annotate +68+580 'ONE WITNESS  /  EXTENDED MEASURE FIRST  /  FINITE-TARGET PROJECTION  /  NO KINGMAN CLAIM' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "from-finite-centered-bad-block-bounds-to-all-positive-length-control-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified from-finite-centered-bad-block-bounds-to-all-positive-length-control-card.png"
fi
