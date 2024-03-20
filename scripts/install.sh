#!/bin/sh
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
NO_COLOR="\033[0m"
CHECKMARK="\xE2\x9C\x94"
INFO="\xE2\x84\xB9"
CROSS="\xE2\x9D\x8C"

handle_error() {
  printf "%s%s An error occurred: %s, exiting%s\n" "$RED" "$CROSS" "$1" "$NO_COLOR"
  exit 1
}

success_message() {
  printf "%s%s %s%s\n" "$GREEN" "$CHECKMARK" "$1" "$NO_COLOR"
}

info_message() {
  printf "%s%s %s%s\n" "$BLUE" "$INFO" "$1" "$NO_COLOR"
}

install_homebrew() {
  info_message "Installing Homebrew..."
  if ! command -v brew > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    printf "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" >> /Users/mac/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  success_message "Homebrew installed"
}

clone_configuration() {
  info_message "Cloning configuration"
  if [ -d "$HOME/.config" ]; then
    info_message "~/.config already exists"
  else
    git clone https://github.com/maclong9/dotfiles "$HOME/.config"
  fi
  success_message "Configuration cloned"
}

install_tools() {
  info_message "Installing tools..."
  brew install deno mas
  brew install --cask element hyperkey orbstack osu texifier
  mas install 1289583905 # 424390742 424389933 634148309 634159523 434290957 497799835 1289583905 
  # ^ Compressor, Final Cut Pro, Logic Pro, MainStage, Motion, Xcode, Pixelmator Pro
  open -a element hyperkey 
  success_message "Tooling installed"
}

link_configuration() {
   info_message "Linking configuration files..."
   for file in gitconfig vimrc zshrc; do
     ln -s "$HOME/.config/$file" "$HOME/.$file"
   done
   success_message "Configuration linked"
}

setup_cron() {
  info_message "Scheduling routine jobs"
  printf "0 12 * * 1 %s/.config/scripts/maintenance.sh" "$HOME" | crontab -
  success_message "Jobs scheduled"
}

install_homebrew || handle_error "Failed to install Homebrew"
clone_configuration || handle_error "Failed to clone configuration"
install_tools || handle_error "Failed to install tools"
link_configuration || handle_error "Failed while linking configuration files"
setup_cron || handle_error "Failed to setup cronjob's"
