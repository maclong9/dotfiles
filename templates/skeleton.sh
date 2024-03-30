#!/bin/sh
message() {
  ANSI_PREFIX=$(printf "\033")
  if [ "$1" = "info" ]; then
    color="${ANSI_PREFIX}[34m" # Sets Foreground to Blue
  elif [ "$1" = "success" ]; then
    color="${ANSI_PREFIX}[1A${ANSI_PREFIX}[K${ANSI_PREFIX}[32m" # Clears previous line & sets Foreground to Green
  fi

  printf "%s[%s] %s%s\n" "$color" "$1" "${ANSI_PREFIX}[0m" "$2"
}

