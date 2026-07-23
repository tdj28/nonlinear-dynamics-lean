#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
source_svg="$script_dir/two-coordinate-independent-family.svg"
checked="$script_dir/independent-complex-family-card.png"
fit=""
temporary=""

cleanup() {
  test -z "$fit" || rm -f "$fit"
  test -z "$temporary" || rm -f "$temporary"
}
trap cleanup EXIT HUP INT TERM

generate() {
  output="$1"
  fit="$(mktemp /tmp/independent-complex-family-fit.XXXXXX)"
  rsvg-convert -w 922 -h 630 -b '#f7f1e7' -o "$fit" "$source_svg"
  magick "$fit" -background '#f7f1e7' -gravity center \
    -extent 1200x630 -alpha off -strip \
    -define png:exclude-chunk=date,time "PNG:$output"
  rm -f "$fit"
  fit=""

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
  temporary="$(mktemp /tmp/independent-complex-family-card.XXXXXX)"
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "independent-complex-family-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified independent-complex-family-card.png"
  exit 0
fi

if test "$#" -eq 1; then
  generate "$1"
else
  generate "$checked"
fi
