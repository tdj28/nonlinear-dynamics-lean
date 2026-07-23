#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
source_svg="$script_dir/infinite-horizon-exceedance-event.svg"
checked="$script_dir/infinite-horizon-birkhoff-average-exceedance-event-card.png"
fit=""
temporary=""

cleanup() {
  test -z "$fit" || rm -f "$fit"
  test -z "$temporary" || rm -f "$temporary"
}
trap cleanup EXIT HUP INT TERM

generate() {
  output="$1"
  fit="$(mktemp /tmp/infinite-horizon-exceedance-event-fit.XXXXXX)"
  rsvg-convert -w 656 -h 630 -b '#f7f1e7' \
    -o "$fit" "$source_svg"
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

if test "$#" -gt 0 && test "$1" = "--verify"; then
  temporary="$(mktemp /tmp/infinite-horizon-exceedance-event-card.XXXXXX)"
  generate "$temporary"
  cmp -s "$temporary" "$checked" || {
    echo "infinite-horizon-birkhoff-average-exceedance-event-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified infinite-horizon-birkhoff-average-exceedance-event-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
