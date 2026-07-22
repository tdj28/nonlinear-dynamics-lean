#!/bin/sh
set -eu

# The empty CDPATH assignment is the repository convention for silent lookup.
# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/conditional-expectation-card.png"
verify=false

if test "$#" -gt 0 && test "$1" = "--verify"; then
  output="$(mktemp "/tmp/conditional-expectation-card.XXXXXX")"
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
  -fill '#16243A' -font Palatino-Roman -pointsize 48 \
  -annotate +67+157 'Conditional' \
  -annotate +67+215 'expectation' \
  -fill '#4D5B6B' -font Helvetica -pointsize 18 \
  -annotate +70+274 'Forget invisible variation while preserving' \
  -annotate +70+302 'every visible-set integral.' \
  -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 2 \
  -draw 'roundrectangle 610,70 1140,478 22,22' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 648,101 1102,181 13,13' \
  -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +680+130 'FINE VALUES' \
  -fill '#16243A' -font Helvetica-Bold -pointsize 24 \
  -annotate +811+161 '1   3  |  2   6' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 875,187 875,218 polygon 868,211 882,211 875,222' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'roundrectangle 648,232 1102,302 13,13' \
  -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +742+274 'TWO VISIBLE CELLS' \
  -fill none -stroke '#A67C52' -strokewidth 3 \
  -draw 'line 875,308 875,339 polygon 868,332 882,332 875,343' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 648,353 1102,433 13,13' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +680+382 'COARSE VALUES' \
  -fill '#16243A' -font Helvetica-Bold -pointsize 24 \
  -annotate +811+416 '2   2  |  4   4' \
  -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
  -draw 'roundrectangle 68,374 554,450 15,15' \
  -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 16 \
  -annotate +108+405 'CELL TOTALS STAY 4 AND 8' \
  -fill '#4D5B6B' -font Helvetica -pointsize 14 \
  -annotate +108+430 'Uniqueness is almost everywhere.' \
  -fill '#FFFDF8' -font Helvetica -pointsize 16 \
  -annotate +68+580 'COARSE INFORMATION  /  MEASURABLE  /  INTEGRAL-PRESERVING  /  UNIQUE MOD NULL SETS' \
  -strip -define png:exclude-chunk=date,time \
  "PNG:$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "conditional-expectation-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified conditional-expectation-card.png"
fi
