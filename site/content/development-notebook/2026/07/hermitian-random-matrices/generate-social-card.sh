#!/usr/bin/env bash
set -euo pipefail

card_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
output_path="$card_dir/hermitian-random-matrices-card.png"
magick_bin="${MAGICK_BIN:-magick}"

if ! command -v "$magick_bin" >/dev/null 2>&1; then
  echo "ImageMagick 7 is required. Install it, then rerun this generator." >&2
  exit 1
fi

pick_font() {
  local query="$1"
  local fallback="$2"
  local matched=""
  if command -v fc-match >/dev/null 2>&1; then
    matched="$(fc-match -f '%{file}\n' "$query" | sed -n '1p')"
  fi
  printf '%s' "${matched:-$fallback}"
}

font_regular="$(pick_font 'Avenir Next:style=Regular' 'Helvetica')"
font_semibold="$(pick_font 'Avenir Next:style=Demi Bold' 'Helvetica-Bold')"
font_mono="$(pick_font 'Andale Mono:style=Regular' 'Courier')"

"$magick_bin" \
  -size 1200x630 canvas:'#F7F4F0' \
  -stroke '#D9D0C4' -strokewidth 1 -fill none \
  -draw "path 'M 0,105 C 180,57 340,155 520,105 S 880,57 1200,105'" \
  -draw "path 'M 0,135 C 190,87 350,185 530,135 S 890,87 1200,135'" \
  -draw "path 'M 0,165 C 200,117 360,215 540,165 S 900,117 1200,165'" \
  -stroke '#C9BEAE' -strokewidth 1 \
  -draw 'line 56,80 1144,80' \
  -fill '#C16F2C' -stroke none -font "$font_mono" -pointsize 16 \
  -annotate +56+64 'DEVELOPMENT NOTEBOOK  /  LEAN COMPANION' \
  -fill '#16243A' -font "$font_semibold" -pointsize 62 \
  -annotate +56+171 'HERMITIAN' \
  -font "$font_semibold" -pointsize 55 \
  -annotate +56+239 'RANDOM MATRICES' \
  -fill '#4D5B6B' -font "$font_regular" -pointsize 25 \
  -annotate +60+292 'Three levels of truth. One usable interface.' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'roundrectangle 60,338 623,455 18,18' \
  -fill '#16243A' -stroke none -font "$font_mono" -pointsize 17 \
  -annotate +88+377 'EVERY SAMPLE' \
  -annotate +88+411 'ALMOST SURE' \
  -annotate +88+445 'MEASURABLE' \
  -fill '#C16F2C' -font "$font_semibold" -pointsize 18 \
  -annotate +278+377 'pointwise symmetry' \
  -fill '#284E72' \
  -annotate +278+411 'null sets allowed' \
  -fill '#315F55' \
  -annotate +278+445 'probability can observe it' \
  -fill '#FFFDF8' -stroke '#C9BEAE' -strokewidth 2 \
  -draw 'roundrectangle 690,92 1144,520 24,24' \
  -fill '#4D5B6B' -stroke none -font "$font_mono" -pointsize 14 \
  -annotate +724+128 'CONJUGATE SYMMETRY' \
  -stroke '#C16F2C' -strokewidth 4 -fill none \
  -draw "path 'M 758,175 L 742,175 L 742,425 L 758,425'" \
  -draw "path 'M 1076,175 L 1092,175 L 1092,425 L 1076,425'" \
  -stroke '#D9D0C4' -strokewidth 2 \
  -draw 'line 797,206 1028,390' \
  -draw 'line 915,206 797,390' \
  -draw 'line 1028,206 797,298' \
  -fill '#F3E8E0' -stroke '#A67C52' -strokewidth 2 \
  -draw 'circle 797,206 824,206' \
  -draw 'circle 915,298 942,298' \
  -draw 'circle 1028,390 1055,390' \
  -fill '#E8F0F7' -stroke '#4B6787' -strokewidth 2 \
  -draw 'circle 915,206 942,206' \
  -draw 'circle 1028,206 1055,206' \
  -draw 'circle 797,298 824,298' \
  -draw 'circle 1028,298 1055,298' \
  -draw 'circle 797,390 824,390' \
  -draw 'circle 915,390 942,390' \
  -fill '#16243A' -stroke none -font "$font_mono" -pointsize 15 -gravity northwest \
  -annotate +786+212 'r1' \
  -annotate +897+212 'z12' \
  -annotate +1010+212 'z13' \
  -annotate +776+304 'z12*' \
  -annotate +904+304 'r2' \
  -annotate +1010+304 'z23' \
  -annotate +776+396 'z13*' \
  -annotate +895+396 'z23*' \
  -annotate +1017+396 'r3' \
  -fill '#4D5B6B' -font "$font_regular" -pointsize 17 \
  -annotate +724+474 'real diagonal  /  paired off-diagonal' \
  -fill '#315F55' -stroke none \
  -draw 'roundrectangle 56,540 1144,582 14,14' \
  -fill '#FFFDF8' -font "$font_mono" -pointsize 15 \
  -annotate +82+563 'H(omega)* = H(omega)   |   measurable   |   trace is real' \
  -strip "$output_path"

dimensions="$("$magick_bin" identify -format '%wx%h' "$output_path")"
if [[ "$dimensions" != '1200x630' ]]; then
  echo "Expected 1200x630, generated $dimensions" >&2
  exit 1
fi

echo "Generated $output_path ($dimensions)"
