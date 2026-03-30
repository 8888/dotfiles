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
    sed \
      -e 's/[()]/\x1b[1;33m&\x1b[0m/g' \
      -e 's/[V]/\x1b[1;31m&\x1b[0m/g' \
      -e 's/[/\\]/\x1b[31m&\x1b[0m/g' \
      -e 's/"/\x1b[33m&\x1b[0m/g' \
      -e 's/[=]/\x1b[90m&\x1b[0m/g' \
      -e 's/~/\x1b[36m&\x1b[0m/g' \
      -e 's/CAMP  FIRE/\x1b[1;36m&\x1b[0m/g' \
      "$frame"
    sleep "$FPS"
  done
done
