#!/bin/sh
set -eu

# shellcheck disable=SC1007
script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
checked="$script_dir/forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms-card.png"
verify=false

case "$#" in
  0)
    output="$checked"
    ;;
  1)
    if test "$1" = "--verify"; then
      output="$(mktemp "/tmp/rmt34-deep-dive-card.XXXXXX")"
      verify=true
      trap 'rm -f "$output"' EXIT HUP INT TERM
    else
      output="$1"
    fi
    ;;
  *)
    echo "usage: $0 [--verify|OUTPUT.png]" >&2
    exit 2
    ;;
esac

generate() {
  destination="$1"
  magick -size 1200x630 xc:'#F7F4F0' \
    -fill '#16243A' -stroke none \
    -draw 'rectangle 0,0 1200,18 rectangle 0,558 1200,630' \
    -fill '#A06E43' -font Helvetica-Bold -pointsize 17 \
    -annotate +64+59 'KNOWLEDGE BASE  /  EXACT FINITE LEDGER' \
    -fill '#16243A' -font Palatino-Roman -pointsize 32 \
    -annotate +63+105 'Forward and inverse tails for signed log norms' \
    -fill '#556170' -font Helvetica -pointsize 15 \
    -annotate +66+139 'Exponent steps +2, -3, +1, +2 make every rail and every inverse-order choice visible.' \
    -fill '#FFFDF9' -stroke '#C8BDAE' -strokewidth 2 \
    -draw 'roundrectangle 62,174 807,526 18,18' \
    -fill '#16243A' -stroke none \
    -draw 'roundrectangle 62,174 807,231 18,18 rectangle 62,210 807,231' \
    -font Helvetica-Bold -pointsize 14 -fill '#FFFFFF' \
    -annotate +86+207 'n' \
    -annotate +165+199 'LOWER' -annotate +178+219 '-J' \
    -annotate +291+199 'SIGNED' -annotate +315+219 'R' \
    -annotate +421+199 'CLIPPED' -annotate +449+219 'P' \
    -annotate +551+199 'FORWARD' -annotate +581+219 'U' \
    -annotate +683+199 'INVERSE' -annotate +710+219 'Q' \
    -stroke '#DED6CB' -strokewidth 1 -fill none \
    -draw 'line 62,290 807,290 line 62,348 807,348 line 62,406 807,406 line 62,464 807,464 line 122,174 122,526 line 250,174 250,526 line 382,174 382,526 line 514,174 514,526 line 646,174 646,526' \
    -fill '#F5EDE3' -stroke none -draw 'rectangle 64,348 805,406' \
    -font Helvetica-Bold -pointsize 20 -fill '#263548' \
    -annotate +88+270 '0' -annotate +185+270 '0' -annotate +314+270 '0' -annotate +446+270 '0' -annotate +578+270 '0' -annotate +710+270 '0' \
    -annotate +88+328 '1' -annotate +185+328 '0' -fill '#284E72' -annotate +314+328 '2' -fill '#263548' -annotate +446+328 '2' -annotate +578+328 '2' -annotate +710+328 '0' \
    -annotate +88+386 '2' -fill '#8B3E33' -annotate +177+386 '-3' -annotate +306+386 '-1' -fill '#263548' -annotate +446+386 '0' -fill '#284E72' -annotate +578+386 '2' -fill '#315F55' -annotate +710+386 '1' \
    -fill '#263548' -annotate +88+444 '3' -fill '#8B3E33' -annotate +177+444 '-3' -fill '#263548' -annotate +314+444 '0' -annotate +446+444 '0' -fill '#284E72' -annotate +578+444 '3' -fill '#263548' -annotate +710+444 '0' \
    -annotate +88+502 '4' -fill '#8B3E33' -annotate +177+502 '-3' -fill '#284E72' -annotate +314+502 '2' -fill '#263548' -annotate +446+502 '2' -fill '#284E72' -annotate +578+502 '5' -fill '#263548' -annotate +710+502 '0' \
    -fill '#EAF1E5' -stroke '#6F8D5E' -strokewidth 2 \
    -draw 'roundrectangle 839,174 1138,324 18,18' \
    -fill '#315F55' -stroke none -font Helvetica-Bold -pointsize 14 \
    -annotate +866+207 'ORDER CHECK' \
    -fill '#16243A' -font Palatino-Roman -pointsize 17 \
    -annotate +866+241 'inverse(U L)' \
    -annotate +866+265 '= inverse(L) inverse(U)' \
    -font Helvetica-Bold -pointsize 15 -fill '#39705B' \
    -annotate +866+299 '[[1,-1],[-1,2]]   CORRECT' \
    -fill '#F5DDD8' -stroke '#9A493E' -strokewidth 2 \
    -draw 'roundrectangle 839,342 1138,450 18,18' \
    -fill '#8B3E33' -stroke none -font Helvetica-Bold -pointsize 14 \
    -annotate +866+375 'WRONG ORDER' \
    -fill '#16243A' -font Helvetica-Bold -pointsize 13 \
    -annotate +866+407 'WRONG: inverse(U) inverse(L)' \
    -annotate +866+431 '= [[2,-1],[-1,1]]' \
    -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
    -draw 'roundrectangle 839,468 1138,526 16,16' \
    -fill '#284E72' -stroke none -font Helvetica-Bold -pointsize 11 \
    -annotate +866+489 'SEVERE CONTRACTION' \
    -annotate +866+507 'positive clip = 0 · signed = -100' \
    -annotate +866+522 'inverse tail = 100' \
    -fill '#C7D2DF' -font Helvetica-Bold -pointsize 12 \
    -annotate +64+582 'GATES: POINTWISE UNITS + INTEGRABLE FORWARD AND INVERSE GENERATOR TAILS' \
    -fill '#FFFDF8' -font Helvetica-Bold -pointsize 11 \
    -annotate +64+607 'OUTPUT: LOWER RAIL ≤ SIGNED LOG ≤ POSITIVE LOG  /  INVERSE VALUE ≤ INVERSE-ORBIT SUM  /  FINITE SIGNED SLICES ARE INTEGRABLE' \
    -strip -define png:exclude-chunk=date,time \
    "PNG:$destination"
}

generate "$output"

dimensions="$(magick identify -format '%wx%h' "$output")"
test "$dimensions" = "1200x630" || {
  echo "unexpected card dimensions: $dimensions" >&2
  exit 1
}

if test "$verify" = true; then
  cmp -s "$output" "$checked" || {
    echo "forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms-card.png is stale; regenerate it" >&2
    exit 1
  }
  echo "verified forward-and-inverse-tail-sandwich-for-finite-time-real-log-norms-card.png"
fi
