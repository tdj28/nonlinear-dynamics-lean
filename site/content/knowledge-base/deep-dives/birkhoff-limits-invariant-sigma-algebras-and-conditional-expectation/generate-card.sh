#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/birkhoff-invariant-limit-deep-dive-card.XXXXXX")"
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
  -annotate +58+66 'KNOWLEDGE BASE / DEEP DIVE' \
  -fill '#16243A' -font Palatino-Roman -pointsize 39 \
  -annotate +57+119 'Birkhoff limits as invariant' \
  -annotate +57+165 'conditional expectation' \
  -fill '#4D5B6B' -font Helvetica -pointsize 17 \
  -annotate +60+204 'One exact probability model, computed atom by atom' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 56,238 365,508 18,18' \
  -fill '#E8F0F7' -stroke none \
  -draw 'roundrectangle 57,239 364,286 17,17 rectangle 57,266 364,286' \
  -fill '#284E72' -font Helvetica-Bold -pointsize 16 \
  -annotate +88+270 'FOUR-STATE PROBABILITY MODEL' \
  -fill '#16243A' -font Helvetica-Bold -pointsize 17 \
  -annotate +83+321 'cycles:  a0 <-> a1    b0 <-> b1' \
  -fill '#4D5B6B' -font Helvetica -pointsize 16 \
  -annotate +83+358 'weights: [2/5, 2/5, 1/10, 1/10]' \
  -annotate +83+390 'f values: [1, 7, -3, 5]' \
  -fill '#315F55' -font Helvetica-Bold -pointsize 17 \
  -annotate +83+435 'total mass = 1' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +83+469 'equal weights inside each cycle' \
  -annotate +83+489 'make the swap measure preserving' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 389,238 794,508 18,18' \
  -fill '#EAF1E5' -stroke none \
  -draw 'roundrectangle 390,239 793,286 17,17 rectangle 390,266 793,286' \
  -fill '#315F55' -font Helvetica-Bold -pointsize 16 \
  -annotate +493+270 'INVARIANT ATOM LEDGER' \
  -fill '#16243A' -font Helvetica-Bold -pointsize 18 \
  -annotate +423+327 'A mass 4/5' \
  -annotate +423+360 '(16/5) / (4/5) = 4' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +423+383 'preserves integral 16/5' \
  -fill '#16243A' -font Helvetica-Bold -pointsize 18 \
  -annotate +423+429 'B mass 1/5' \
  -annotate +423+462 '(1/5) / (1/5) = 1' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +423+485 'preserves integral 1/5' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 818,238 1144,508 18,18' \
  -fill '#F3E8E0' -stroke none \
  -draw 'roundrectangle 819,239 1143,286 17,17 rectangle 819,266 1143,286' \
  -fill '#8B3E33' -font Helvetica-Bold -pointsize 16 \
  -annotate +925+270 'EXACT LIMIT' \
  -fill '#16243A' -font Helvetica-Bold -pointsize 22 \
  -annotate +867+335 '[4, 4, 1, 1]' \
  -fill '#4D5B6B' -font Helvetica -pointsize 15 \
  -annotate +853+374 'whole integral: 17/5' \
  -fill '#8B3E33' -font Helvetica-Bold -pointsize 15 \
  -annotate +853+423 'wrong constant 17/5' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +853+453 'on A: 68/25 != 80/25' \
  -annotate +853+478 'sector information was erased' \
  -fill '#FFFDF8' -font Helvetica-Bold -pointsize 16 \
  -annotate +58+578 'TIME AVERAGING REMOVES PHASE, NOT THE INVARIANT SECTOR' \
  -fill '#D8E1EA' -font Helvetica -pointsize 14 \
  -annotate +59+608 'FINITE MEASURE  /  EXACT INVARIANT SIGMA ALGEBRA  /  RUNNABLE LEAN WORKSHEET' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified birkhoff-limits-invariant-sigma-algebras-and-conditional-expectation-card.png"
fi
