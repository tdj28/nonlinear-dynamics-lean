#!/bin/sh
set -eu

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
source_svg="$script_dir/exact-hermitian-perturbation-ledger.svg"
checked="$script_dir/hermitian-spectral-perturbation-continuity-and-measurability-card.png"
work_dir=''
verification_file=''

cleanup() {
  if test -n "$work_dir"; then
    rm -rf "$work_dir"
  fi
  if test -n "$verification_file"; then
    rm -f "$verification_file"
  fi
}

trap cleanup EXIT HUP INT TERM

generate() {
  output="$1"
  work_dir="$(mktemp -d "/tmp/hermitian-perturbation-card.XXXXXX")"
  raw="$work_dir/raw.png"

  rsvg-convert --format=png --width=1200 --height=630 \
    --output="$raw" "$source_svg"
  magick "$raw" -strip "PNG:$output"

  dimensions="$(magick identify -format '%wx%h' "$output")"
  test "$dimensions" = "1200x630" || {
    echo "unexpected card dimensions: $dimensions" >&2
    exit 1
  }

  rm -rf "$work_dir"
  work_dir=''
}

if test "$#" -gt 0 && test "$1" = "--verify"; then
  verification_file="$(mktemp "/tmp/hermitian-perturbation-card-verify.XXXXXX")"
  generate "$verification_file"
  cmp -s "$verification_file" "$checked" || {
    echo "hermitian-spectral-perturbation-continuity-and-measurability-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified hermitian-spectral-perturbation-continuity-and-measurability-card.png"
  exit 0
fi

if test "$#" -gt 0; then
  generate "$1"
else
  generate "$checked"
fi
