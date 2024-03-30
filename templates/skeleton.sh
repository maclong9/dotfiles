#!/bin/sh
message() {
  ansi_pre=$(printf "\033")
  [ "$1" = "info" ] && color="${ansi_pre}[34m" # Blue
  [ "$1" = "success" ] && color="${ansi_pre}[1A${ansi_pre}[K${ansi_pre}[32m" # Clear ^ & Green
  [ "$1" = "error" ] && color="${ansi_pre}[31m" # Red

  printf "%s[%s] %s%s\n" "$color" "$1" "${ansi_pre}[0m" "$2"
}
