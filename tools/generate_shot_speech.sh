#!/usr/bin/env bash
# Regenerates bundled training speech clips for EN (Samantha) and DE (Anna).
# Requires macOS `say` and `afconvert`.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
out="$root/assets/sounds/shots"

# file_name:spoken_word pairs (bash 3.2 compatible — no associative arrays)
shot_pairs=(
  clear:Clear
  drop:Drop
  smash:Smash
  lift:Lift
  block:Block
  tap:Tap
  drive:Drive
)

generate_locale() {
  local lang="$1"
  local voice="$2"
  local dir="$out/$lang"
  mkdir -p "$dir"

  for pair in "${shot_pairs[@]}"; do
    local file="${pair%%:*}"
    local word="${pair##*:}"
    local aiff="$dir/$file.aiff"
    local wav="$dir/$file.wav"
    say -v "$voice" -r 175 -o "$aiff" "$word"
    afconvert -f WAVE -d LEI16@22050 "$aiff" "$wav"
    rm "$aiff"
    echo "Wrote $wav"
  done
}

generate_locale en Samantha
generate_locale de Anna

echo "Done. Generated ${#shot_pairs[@]} clips each for en/ and de/."
