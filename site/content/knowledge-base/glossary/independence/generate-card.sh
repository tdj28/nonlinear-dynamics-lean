#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/independence-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 -annotate +72+104 'GLOSSARY / JOINT LAWS' \
    -fill '#16243A' -font Palatino-Roman -pointsize 76 -annotate +72+226 'Independence' \
    -fill '#4D5B6B' -font Helvetica -pointsize 24 -annotate +76+300 'Joint probabilities factor into marginal probabilities' \
    -fill '#DCE8EE' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 748,108 888,248 12,12 roundrectangle 908,108 1048,248 12,12 roundrectangle 748,268 888,408 12,12 roundrectangle 908,268 1048,408 12,12' \
    -stroke none -fill '#284E72' -font Helvetica -pointsize 22 \
    -annotate +792+187 '1/4' -annotate +952+187 '1/4' -annotate +792+347 '1/4' -annotate +952+347 '1/4' \
    -fill '#DCE8DF' -stroke '#6F8D5E' -strokewidth 3 -draw 'roundrectangle 748,438 1048,494 14,14' \
    -stroke none -fill '#315F55' -font Helvetica -pointsize 20 -annotate +780+474 'cell = row x column' \
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
  temporary="$(mktemp "${TMPDIR:-/tmp}/independence-card.XXXXXX.png")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "independence-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified independence-card.png"
  exit 0
fi

generate "${1:-$checked}"
