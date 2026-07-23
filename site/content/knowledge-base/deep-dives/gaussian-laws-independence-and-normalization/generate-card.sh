#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
source_svg="$script_dir/gaussian-product-law-stack.svg"
checked="$script_dir/gaussian-laws-card.png"
full=""
top=""
bottom=""
temporary=""

cleanup() {
  test -z "$full" || rm -f "$full"
  test -z "$top" || rm -f "$top"
  test -z "$bottom" || rm -f "$bottom"
  test -z "$temporary" || rm -f "$temporary"
}
trap cleanup EXIT HUP INT TERM

generate() {
  output="$1"
  full="$(mktemp /tmp/gaussian-laws-card-full.XXXXXX)"
  top="$(mktemp /tmp/gaussian-laws-card-top.XXXXXX)"
  bottom="$(mktemp /tmp/gaussian-laws-card-bottom.XXXXXX)"

  rsvg-convert -w 1200 -h 900 -b '#f7f4f0' -o "$full" "$source_svg"
  magick "$full" -crop 1140x365+30+0 +repage \
    -filter Lanczos -resize '1200x384!' "PNG:$top"
  magick "$full" -crop 1140x215+30+685 +repage \
    -filter Lanczos -resize '1200x226!' "PNG:$bottom"
  magick -size 1200x630 xc:'#f7f4f0' \
    "$top" -geometry +0+0 -composite \
    "$bottom" -geometry +0+404 -composite \
    -alpha off -strip \
    -define png:exclude-chunk=date,time "PNG:$output"
  rm -f "$full" "$top" "$bottom"
  full=""
  top=""
  bottom=""

  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 1; then
  echo "usage: $0 [OUTPUT.png|--verify]" >&2
  exit 2
fi

if test "$#" -eq 1 && test "$1" = "--verify"; then
  temporary="$(mktemp /tmp/gaussian-laws-card.XXXXXX)"
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "gaussian-laws-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified gaussian-laws-card.png"
  exit 0
fi

if test "$#" -eq 1; then
  generate "$1"
else
  generate "$checked"
fi
