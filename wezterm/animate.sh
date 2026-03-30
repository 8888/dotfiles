#!/bin/sh
# ASCII stop-motion animation player
# Press any key to close

FRAMES_DIR="$(dirname "$0")/frames"
FPS=0.18

cleanup() { tput cnorm; printf '\033[?1049l'; stty sane; exit 0; }
trap cleanup INT TERM

printf '\033[?1049h'  # switch to alternate screen buffer
tput civis            # hide cursor
stty -echo -icanon min 0 time 0  # non-blocking key reads

while true; do
  for frame in "$FRAMES_DIR"/frame_*.txt; do
    # check for keypress
    if [ "$(dd bs=1 count=1 2>/dev/null | wc -c)" -gt 0 ]; then
      cleanup
    fi
    # move cursor home and overwrite in place (no clear = no flicker)
    printf '\033[H'
    cat "$frame"
    sleep "$FPS"
  done
done
