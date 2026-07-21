#!/bin/sh
set -eu

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/weyl-eigenvalue-bound-card.png"

generate() {
  output="$1"
  magick -size 1200x630 xc:'#F3EFE6' \
    -fill '#16243A' -draw 'rectangle 0,0 1200,22 rectangle 0,535 1200,630' \
    -fill '#C16F2C' -font Helvetica -pointsize 22 \
    -annotate +72+96 'KNOWLEDGE BASE / SPECTRAL STABILITY' \
    -fill '#16243A' -font Palatino-Roman -pointsize 48 \
    -annotate +72+180 'Weyl eigenvalue' \
    -annotate +72+242 'perturbation bound' \
    -fill '#4D5B6B' -font Helvetica -pointsize 20 \
    -annotate +76+306 'One matrix budget controls every ordered level' \
    -fill '#FBF9F6' -stroke '#C4B8A8' -strokewidth 3 \
    -draw 'roundrectangle 720,62 1154,472 22,22' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 3 \
    -draw 'roundrectangle 758,96 1116,166 14,14' \
    -fill '#16243A' -stroke none -font Helvetica -pointsize 16 \
    -annotate +822+127 'HERMITIAN MATRICES' \
    -font Helvetica -pointsize 13 -annotate +816+151 'COMPARE IN FROBENIUS GEOMETRY' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 937,173 937,211' \
    -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 3 \
    -draw 'roundrectangle 758,218 1116,300 14,14' \
    -fill '#934F1F' -stroke none -font Helvetica -pointsize 16 \
    -annotate +812+250 'ONE PERTURBATION BUDGET' \
    -font Helvetica -pointsize 13 -annotate +822+277 'DETERMINISTIC CONTROL' \
    -fill none -stroke '#A67C52' -strokewidth 3 \
    -draw 'line 937,307 937,345' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 3 \
    -draw 'roundrectangle 758,352 1116,423 14,14' \
    -fill '#315F55' -stroke none -font Helvetica -pointsize 15 \
    -annotate +804+382 'EVERY ORDERED LEVEL STAYS CLOSE' \
    -font Helvetica -pointsize 12 -annotate +828+407 'EIGENVECTORS ARE A SEPARATE QUESTION' \
    -fill '#4D5B6B' -font Helvetica -pointsize 13 \
    -annotate +826+451 'BOUND  /  LIPSCHITZ  /  MEASURABLE' \
    -fill '#FFFDF8' -font Helvetica -pointsize 18 \
    -annotate +72+578 'FROBENIUS NORM  /  ORDERED SPECTRUM  /  CONTINUITY  /  GIRY' \
    -strip \
    "PNG:$output"
  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp "/tmp/weyl-eigenvalue-bound-card.XXXXXX")"
  trap 'rm -f "$temporary"' EXIT HUP INT TERM
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "weyl-eigenvalue-bound-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified weyl-eigenvalue-bound-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
