#!/bin/bash

ALLOW_LIST=(
  ".config"
  ".xinitrc"
)

dmenufont="monospace-10"
col_gray1="#222222"
col_gray3="#bbbbbb"
col_cyan="#005577"
col_gray4="#eeeeee"

# configuration
dmenu="dmenu -i -fn $dmenufont -nb $col_gray1 -nf $col_gray3 -sb $col_cyan -sf $col_gray4"

# Working out of dir - currently home dir
DIRECTORY=$HOME
CACHE_FILE="$DIRECTORY/.cache/.dmenu_cache"
CACHE_TIMESTAMP="$DIRECTORY/.cache/.dmenu_cache_timestamp"

check_update_cache() {
  local current_time=$(date +%s)
  local last_update=0

  if [ -f "$CACHE_TIMESTAMP" ]; then
    last_update=$(cat "$CACHE_TIMESTAMP")
  fi

  # checks every 5 hours
  if [ $((current_time - last_update)) -gt 18000 ]; then
    echo "$current_time" > "$CACHE_TIMESTAMP"

    find "$DIRECTORY" -print | while read -r path; do
      relative_path="${path#$DIRECTORY/}"
      
      # checks if the relative path starts with a dot and is not in the allow list
      if [[ "$relative_path" == .* && ! " ${ALLOW_LIST[@]} " =~ " ${relative_path%%/*} " ]]; then
        continue
      fi
      
      if [ -d "$path" ]; then
        echo "${relative_path}/"
      else
        echo "$relative_path"
      fi
    done > "$CACHE_FILE"
  fi
}

check_update_cache

# list of valid commands and ensure unique entries
# COMMANDS=$(compgen -c | while read cmd; do command -v "$cmd" >/dev/null 2>&1 && echo "$cmd"; done | sort -u)
COMMANDS=$(compgen -c | while read cmd; do command -v "$cmd" >/dev/null 2>&1 && echo "$cmd"; done | sort -u)
SELECTED=$( (cat "$CACHE_FILE"; echo "$COMMANDS" | sed '1,8d') | sort -u | $dmenu)
EXPANDED_PATH=$(realpath -m "$DIRECTORY/$SELECTED")

if [ -z "$SELECTED" ]; then
  pass
elif [ "$SELECTED" = "$DIRECTORY" ]; then
  st &
elif command -v "$SELECTED" >/dev/null 2>&1 && [ ! -f "$EXPANDED_PATH" ]; then
  $SELECTED &
elif [ -d "$EXPANDED_PATH" ]; then
  st -e bash -c "cd \"$EXPANDED_PATH\" && exec bash"
elif [ -f "$EXPANDED_PATH" ]; then
  subl4 "$EXPANDED_PATH" &
fi

