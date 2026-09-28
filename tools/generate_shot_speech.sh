#!/usr/bin/env bash
# Regenerates bundled training speech clips for EN, DE, and VI.
# Requires macOS `say` and `afconvert`.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
out="$root/assets/sounds/shots"

# Asset file stem : spoken word (EN/DE — international terms)
shot_pairs=(
  clear:Clear
  drop:Drop
  smash:Smash
  lift:Lift
  block:Block
  tap:Tap
  drive:Drive
)

# Asset file stem : spoken word (VI — matches lib/l10n/app_vi.arb shot* keys)
vi_shot_pairs=(
  'clear:Phông'
  'drop:Bỏ nhỏ'
  'smash:Đập'
  'lift:Hất'
  'block:Kê lưới'
  'tap:Vồ'
  'drive:Tạt'
)

generate_from_pairs() {
  local lang="$1"
  local voice="$2"
  shift 2
  local pairs=("$@")
  local dir="$out/$lang"
  mkdir -p "$dir"

  for pair in "${pairs[@]}"; do
    local file="${pair%%:*}"
    local word="${pair#*:}"
    local aiff="$dir/$file.aiff"
    local wav="$dir/$file.wav"
    say -v "$voice" -r 175 -o "$aiff" "$word"
    afconvert -f WAVE -d LEI16@22050 "$aiff" "$wav"
    rm "$aiff"
    echo "Wrote $wav ($word)"
  done
}

generate_from_pairs en Samantha "${shot_pairs[@]}"
generate_from_pairs de Anna "${shot_pairs[@]}"
generate_from_pairs vi Linh "${vi_shot_pairs[@]}"

echo "Done. Generated clips for en/, de/, and vi/."
