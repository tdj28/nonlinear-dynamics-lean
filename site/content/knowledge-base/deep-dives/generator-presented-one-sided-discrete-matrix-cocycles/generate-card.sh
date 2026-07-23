#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
source_svg="$script_dir/one-sided-cocycle-two-block-split.svg"
checked="$script_dir/generator-presented-one-sided-discrete-matrix-cocycles-card.png"
raster=""
temporary=""

cleanup() {
  test -z "$raster" || rm -f "$raster"
  test -z "$temporary" || rm -f "$temporary"
}
trap cleanup EXIT HUP INT TERM

generate() {
  output="$1"
  raster="$(mktemp /tmp/generator-cocycle-card-raster.XXXXXX)"
  rsvg-convert -w 1200 -h 630 -b '#f7f1e7' -o "$raster" "$source_svg"
  magick "$raster" -alpha off -strip \
    -define png:exclude-chunk=date,time "PNG:$output"
  rm -f "$raster"
  raster=""

  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp /tmp/generator-cocycle-card.XXXXXX)"
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "generator-presented-one-sided-discrete-matrix-cocycles-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified generator-presented-one-sided-discrete-matrix-cocycles-card.png"
  exit 0
fi

if test "$#" -gt 1; then
  echo "usage: $0 [OUTPUT.png|--verify]" >&2
  exit 2
fi

generate "${1:-$checked}"
