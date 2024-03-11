#!/bin/sh

handle_error() {
  echo "An error occurred: $1"
  exit 1
}

install_homebrew() {
  if ! [ -x "$(command -v brew)" > /dev/null ]; 
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)" >> /Users/mac/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
}
 

install_ansible() {
  if ! [ -x "$(command -v ansible)" > /dev/null ]; then
    case "$(uname -s)" in
      "Darwin")
	install_homebrew || error "Failed to install Homebrew."
        brew install ansible
        ;;
      "Linux")
        xbps-install -S ansible git
        ;;
      *)
        handle_error "Unsupported system"
        ;;
    esac
  fi
}

clone_configuration() {
  if [ -e "$HOME/.config" ]; then  # Adjusted directory check syntax
    echo "Configuration folder already exists."
  else
    git clone https://github.com/maclong9/dotfiles "$HOME/.config"
  fi
}

run_playbook() {
  case "$1" in
    "prepare")
      ansible-playbook "$HOME/.config/setup/prepare.yml" --ask-become-pass  # Corrected playbook path and option
      ;;
    "initialise")
      ansible-playbook "$HOME/.config/setup/initialise.yml" --ask-become-pass  # Corrected playbook path and option
      ;;
    *)
      handle_error "Invalid playbook specified: $1"
      ;;
  esac
}

install_ansible || handle_error "Failed to install ansible."
clone_configuration || handle_error "Failed to clone configuration."
run_playbook "$1" || handle_error "Failed to execute $1 playbook."
exit 0
