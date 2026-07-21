#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/normalization-convention-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 -annotate +72+104 'GLOSSARY / CONVENTIONS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 66 -annotate +72+210 'Normalization' \
    -fill '#16243A' -font Palatino-Roman -pointsize 66 -annotate +72+282 'convention' \
    -fill '#4D5B6B' -font Helvetica -pointsize 24 -annotate +76+350 'Write down every scale before naming the model' \
    -fill '#DCE8EE' -stroke '#4B6787' -strokewidth 3 -draw 'roundrectangle 704,204 842,342 16,16' \
    -fill '#C16F2C' -stroke '#C16F2C' -strokewidth 4 \
    -draw 'line 852,250 908,182 polygon 908,182 884,190 904,208 line 852,296 908,374 polygon 908,374 904,348 884,366' \
    -fill '#DCE8DF' -stroke '#6F8D5E' -strokewidth 3 -draw 'roundrectangle 920,108 1090,260 16,16' \
    -fill '#F0DBC3' -stroke '#A67C52' -strokewidth 3 -draw 'roundrectangle 920,316 1090,468 16,16' \
    -stroke none -fill '#16243A' -font Helvetica -pointsize 20 \
    -annotate +734+280 'raw laws' -annotate +952+177 'scale A' -annotate +952+385 'scale B' \
    -fill '#315F55' -font Helvetica -pointsize 18 -annotate +946+217 'energy 1' \
    -fill '#934F1F' -font Helvetica -pointsize 18 -annotate +946+425 'energy 2' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 -annotate +72+578 'NONLINEAR DYNAMICS, FORMALLY' \
    -strip \
    "$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "${1:-}" = "--verify"; then
  temporary="$(mktemp "${TMPDIR:-/tmp}/normalization-card.XXXXXX.png")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "normalization-convention-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified normalization-convention-card.png"
  exit 0
fi

generate "${1:-$checked}"
