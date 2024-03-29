#!/bin/sh
message() {
  ANSI_PREFIX=$(printf "\033")
  if [ "$1" = "info" ]; then
    printf "%s" "${ANSI_PREFIX}[34m" # Sets Foreground to Blue
  elif [ "$1" = "error" ]; then
    printf "%s" "${ANSI_PREFIX}[31m" # Sets Foreground to Red
  elif [ "$1" = "success" ]; then
    printf "%s" "${ANSI_PREFIX}[32m" # Sets Foreground to Green
    printf "%s[1A%s[K" "${ANSI_PREFIX}" "${ANSI_PREFIX}" # Clears Previous Line
  fi
  
  printf "%s%s[0m\n" "$2" "${ANSI_PREFIX}" # Prints message & clears previous Foreground color
  
  if [ "$1" = "error" ]; then
    exit 1
  fi
}
