#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
source_svg="$script_dir/hermitian-2x2-spectrum-ledger.svg"
checked="$script_dir/finite-hermitian-spectra-and-empirical-measures-card.png"
fit=""
temporary=""

cleanup() {
  test -z "$fit" || rm -f "$fit"
  test -z "$temporary" || rm -f "$temporary"
}
trap cleanup EXIT HUP INT TERM

generate() {
  output="$1"
  fit="$(mktemp /tmp/finite-hermitian-spectra-card-fit.XXXXXX.png)"
  rsvg-convert -w 995 -h 630 -b '#f7f1e7' -o "$fit" "$source_svg"
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

case "${1:-}" in
  "")
    generate "$checked"
    ;;
  --verify)
    temporary="$(mktemp /tmp/finite-hermitian-spectra-card.XXXXXX.png)"
    generate "$temporary"
    if ! cmp -s "$temporary" "$checked"; then
      echo "card is stale; run ./generate-card.sh" >&2
      exit 1
    fi
    rm -f "$temporary"
    temporary=""
    ;;
  *)
    echo "usage: $0 [--verify]" >&2
    exit 2
    ;;
esac
