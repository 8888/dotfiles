#!/bin/sh
# ASCII stop-motion animation player — stars. Press any key to close.

SCRIPT_DIR="$(dirname "$0")"
ANIM_DIR="$SCRIPT_DIR/frames/stars"
FPS=0.5
SED_FILE="$ANIM_DIR/colors.sed"

printf '\033[?1049h'  # switch to alternate screen buffer
tput civis            # hide cursor
stty -echo -icanon min 0 time 0  # non-blocking key reads

# Pre-render frames into temp files so the loop has zero I/O variance
TMPDIR_FRAMES="$(mktemp -d)"
FRAME_COUNT=0
for frame in "$ANIM_DIR"/frame_*.txt; do
  if [ -f "$SED_FILE" ]; then
    sed -f "$SED_FILE" "$frame" > "$TMPDIR_FRAMES/$FRAME_COUNT"
  else
    cp "$frame" "$TMPDIR_FRAMES/$FRAME_COUNT"
  fi
  FRAME_COUNT=$((FRAME_COUNT + 1))
done

cleanup() { tput cnorm; printf '\033[?1049l'; stty sane; rm -rf "$TMPDIR_FRAMES"; exit 0; }
trap cleanup INT TERM

# Cycle forever with consistent timing — no re-globbing, no I/O jitter
i=0
while true; do
  printf '\033[H'
  cat "$TMPDIR_FRAMES/$i"
  sleep "$FPS"
  # check for keypress
  if [ "$(dd bs=1 count=1 2>/dev/null | wc -c)" -gt 0 ]; then
    cleanup
  fi
  i=$(( (i + 1) % FRAME_COUNT ))
done
