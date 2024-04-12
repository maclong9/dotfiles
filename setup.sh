#!/bin/sh -e
DOT_DIR="$HOME/.config"
ANSI_PRE=$(printf "\033")
PREV_CLEAR=$(printf "${ANSI_PRE}[1A${ANSI_PRE}[K")

message() {
  [ "$1" = "info" ] && color="${ANSI_PRE}[34m" # Blue
  [ "$1" = "success" ] && color="${PREV_CLEAR}${ansi_pre}[32m" # Clear ^ & Green
  [ "$1" = "error" ] && color="${ANSI_PRE}[31m" # Red

  printf "%s[%s] %s%s\n" "$color" "$1" "${ansi_pre}[0m" "$2"
}

install_xcli() {
  if ! command -v git > /dev/null && [ "$(uname)" = "Darwin" ]; then
    message "info" "Installing Xcode Developer Tools..."   
    xcode-select --install
    sudo xcodebuild -license accept     
    message "success" "Xcode Developer Tools installed"
  fi
}

install_tooling() {
  if ! command -v deno > /dev/null; then
    message "info" "Installing Tooling..."
    curl -SLs "https://deno.land/install.sh" | sh >/dev/null 2>&1
    message "success" "Tooling installed"
  fi
}

clone_configuration() {
  if [ -d "$DOT_DIR" ]; then
    message "info" "$HOME/.config already exists, setting \$DOT_DIR to \"\$HOME/.dotfiles\""
    DOT_DIR="$HOME/.dotfiles"
    message "info" "$PREV_CLEAR Cloning configuration..."
    git clone -q "https://github.com/maclong9/dotfiles" "$HOME/.config"
    message "success" "Configuration cloned"
  fi
}

link_configuration() {
   message "info" "Linking configuration files..." 
   for file in "gitconfig" "gitignore" "vimrc" "zshrc"; do
     ln -s "$DOT_DIR/$file" "$HOME/.$file"
   done 
   message "success" "Configuration linked"
}

main() {
  message "info" "System Initialising"
  install_xcli 
  install_tooling 
  clone_configuration
  link_configuration 
  message "success" "System configuration complete, enjoy."
}

main
