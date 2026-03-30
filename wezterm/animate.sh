#!/bin/sh
# ASCII stop-motion animation player
# Randomly selects an animation, then loops it. Press any key to close.

SCRIPT_DIR="$(dirname "$0")"
FRAMES_DIR="$SCRIPT_DIR/frames"
DEFAULT_FPS=0.18

# Collect animation directories
animations=""
count=0
for d in "$FRAMES_DIR"/*/; do
  if ls "$d"frame_*.txt >/dev/null 2>&1; then
    animations="$animations|$d"
    count=$((count + 1))
  fi
done

if [ "$count" -eq 0 ]; then
  echo "No animations found in $FRAMES_DIR" >&2
  exit 1
fi

# Pick a random animation
pick=$(( $(od -An -tu4 -N4 /dev/urandom | tr -d ' ') % count ))
i=0
IFS='|'
for d in $animations; do
  [ -z "$d" ] && continue
  if [ "$i" -eq "$pick" ]; then
    ANIM_DIR="$d"
    break
  fi
  i=$((i + 1))
done
unset IFS

# Load per-animation FPS if available
FPS="$DEFAULT_FPS"
[ -f "$ANIM_DIR/config" ] && . "$ANIM_DIR/config"

# Determine color sed file
SED_FILE="$ANIM_DIR/colors.sed"

cleanup() { tput cnorm; printf '\033[?1049l'; stty sane; exit 0; }
trap cleanup INT TERM

printf '\033[?1049h'  # switch to alternate screen buffer
tput civis            # hide cursor
stty -echo -icanon min 0 time 0  # non-blocking key reads

while true; do
  for frame in "$ANIM_DIR"/frame_*.txt; do
    # check for keypress
    if [ "$(dd bs=1 count=1 2>/dev/null | wc -c)" -gt 0 ]; then
      cleanup
    fi
    # move cursor home and overwrite in place (no clear = no flicker)
    printf '\033[H'
    if [ -f "$SED_FILE" ]; then
      sed -f "$SED_FILE" "$frame"
    else
      cat "$frame"
    fi
    sleep "$FPS"
  done
done
