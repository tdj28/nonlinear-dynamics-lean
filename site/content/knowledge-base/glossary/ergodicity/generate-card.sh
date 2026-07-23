#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
source_svg="$script_dir/finite-ergodicity-comparison.svg"
checked="$script_dir/ergodicity-card.png"
source_png=""
header=""
system_a=""
system_b=""
temporary=""

cleanup() {
  test -z "$source_png" || rm -f "$source_png"
  test -z "$header" || rm -f "$header"
  test -z "$system_a" || rm -f "$system_a"
  test -z "$system_b" || rm -f "$system_b"
  test -z "$temporary" || rm -f "$temporary"
}
trap cleanup EXIT HUP INT TERM

generate() {
  output="$1"
  source_png="$(mktemp /tmp/ergodicity-source.XXXXXX)"
  header="$(mktemp /tmp/ergodicity-header.XXXXXX)"
  system_a="$(mktemp /tmp/ergodicity-system-a.XXXXXX)"
  system_b="$(mktemp /tmp/ergodicity-system-b.XXXXXX)"

  rsvg-convert -f png -w 760 -h 1410 -b '#f7f1e7' \
    -o "$source_png" "$source_svg"
  magick "$source_png" -crop 760x82+0+0 +repage -resize 900x \
    "PNG:$header"
  magick "$source_png" -crop 712x400+24+88 +repage -resize 570x \
    "PNG:$system_a"
  magick "$source_png" -crop 712x449+24+514 +repage -resize 570x \
    "PNG:$system_b"

  magick -size 1200x630 xc:'#f7f1e7' \
    "$header" -gravity north -geometry +0+10 -composite \
    "$system_a" -gravity southwest -geometry +18+38 -composite \
    "$system_b" -gravity southeast -geometry +18+38 -composite \
    -alpha off -strip -define png:exclude-chunk=date,time "PNG:$output"

  rm -f "$source_png" "$header" "$system_a" "$system_b"
  source_png=""
  header=""
  system_a=""
  system_b=""

  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp /tmp/ergodicity-card.XXXXXX)"
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "ergodicity-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified ergodicity-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
