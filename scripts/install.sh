#!/bin/sh
handle_error() {
  echo "An error occurred: $1"
  exit 1
}

install_homebrew() {
  if ! command -v brew > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" >> /Users/mac/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
}

install_ansible() {
  if ! command -v ansible > /dev/null; then
    if [ "$(uname)" = "Darwin" ]; then
        install_homebrew || handle_error "Failed to install Homebrew."
        brew install ansible
    elif [ -d "/etc/runit/runsvdir" ]; then
        sudo xbps-install -Syu ansible git
    else
        handle_error "Unsupported system"
    fi
  fi
}

clone_configuration() {
  if [ -d "$HOME/.config" ]; then
    echo "Configuration folder already exists."
  else
    git clone https://github.com/maclong9/dotfiles "$HOME/.config"
  fi
}

run_playbook() {
  case "$1" in
    "prepare")
      ansible-playbook "$HOME/.config/setup/prepare.yml" --ask-become-pass
      ;;
    "initialise")
      ansible-playbook "$HOME/.config/setup/initialise.yml" --ask-become-pass
      ;;
    *)
      handle_error "Invalid playbook specified: $1"
      ;;
  esac
}

install_ansible || handle_error "Failed to install Ansible."
clone_configuration || handle_error "Failed to clone configuration."
run_playbook "$1" || handle_error "Failed to execute $1 playbook."
exit 0
