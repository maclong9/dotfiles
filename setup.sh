#!/bin/sh -e
message() {
  ANSI_PREFIX=$(printf "\033")
  if [ "$1" = "info" ]; then
    printf "[info] %s" "${ANSI_PREFIX}[34m" # Sets Foreground to Blue
  elif [ "$1" = "success" ]; then
    printf "[success] %s" "${ANSI_PREFIX}[32m" # Sets Foreground to Green
    printf "%s[1A%s[K" "${ANSI_PREFIX}" "${ANSI_PREFIX}" # Clears Previous Line
  fi
  
  printf "%s%s[0m\n" "$2" "${ANSI_PREFIX}" # Prints message & clears previous Foreground color
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
  if [ "$(uname)" != "Darwin" ]; then
    pkg install curl git vim
  fi
  
  if ! command -v deno > /dev/null; then
    message "info" "Installing Tooling..."
    curl -SLs "https://deno.land/install.sh" | sh >/dev/null 2>&1
    message "success" "Tooling installed"
  fi
}

clone_configuration() {
  if [ -d "$HOME/.config" ]; then
    message "info" "$HOME/.config already exists"
  else
		message "info" "Cloning configuration..."
    git clone -q "https://github.com/maclong9/dotfiles" "$HOME/.config"
    message "success" "Configuration cloned"
  fi
}

link_configuration() {
   message "info" "Linking configuration files..." 
   for file in "gitconfig" "vimrc" "zshrc"; do
     ln -s "$HOME/.config/$file" "$HOME/.$file"
   done 
   message "success" "Configuration linked"
}

message "info" "System Initialising"
install_xcli 
install_tooling 
clone_configuration
link_configuration 
message "success" "System configuration complete, enjoy."
