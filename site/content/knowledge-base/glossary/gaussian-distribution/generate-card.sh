#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/gaussian-distribution-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 -annotate +72+104 'GLOSSARY / PROBABILITY' \
    -fill '#16243A' -font Palatino-Roman -pointsize 72 -annotate +72+205 'Gaussian' \
    -fill '#16243A' -font Palatino-Roman -pointsize 72 -annotate +72+282 'distribution' \
    -fill '#4D5B6B' -font Helvetica -pointsize 24 -annotate +76+350 'An exact law with a mean and a variance' \
    -fill '#284E72' -stroke '#4B6787' -strokewidth 3 -draw 'roundrectangle 704,110 846,252 18,18' \
    -fill '#FFFDF8' -stroke none -draw 'roundrectangle 724,130 826,232 12,12' \
    -fill '#C16F2C' -stroke '#C16F2C' -strokewidth 4 \
    -draw 'line 856,181 910,181 polygon 910,181 894,167 894,195' \
    -fill '#F0DBC3' -stroke '#A67C52' -strokewidth 3 -draw 'roundrectangle 920,110 1062,252 18,18' \
    -fill '#FFFDF8' -stroke none -draw 'roundrectangle 940,130 1042,232 12,12' \
    -fill '#C16F2C' -stroke '#C16F2C' -strokewidth 4 \
    -draw 'line 775,267 775,320 polygon 775,320 761,304 789,304' \
    -fill '#DCE8DF' -stroke '#6F8D5E' -strokewidth 3 -draw 'roundrectangle 704,334 1062,468 18,18' \
    -stroke none -fill '#16243A' -font Helvetica -pointsize 20 \
    -annotate +738+187 'standard' -annotate +954+187 'scale' -annotate +750+393 'shift sets mean; scale sets variance' \
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
  temporary="$(mktemp "${TMPDIR:-/tmp}/gaussian-card.XXXXXX.png")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "gaussian-distribution-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified gaussian-distribution-card.png"
  exit 0
fi

generate "${1:-$checked}"
