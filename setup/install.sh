#!/bin/sh
handle_error() {
  echo "An error occurred: $1"
  exit 1
}

case "$(uname -s)" in
  "Darwin")
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh || handle_error "Failed to install Homebrew."
    echo "eval \$($(brew --prefix)/bin/brew shellenv)" >> "$HOME/.zprofile" || handle_error "Failed to setup Homebrew environment."
    . "$HOME/.zprofile"
    brew install ansible git || handle_error "Failed to install Ansible."
    ;;
  "Linux")
    sudo xbps-install ansible || handle_error "Failed to install Ansible."
    ;;
  *)
    handle_error "Unsupported system"
    ;;
esac

git clone https://github.com/mac-codes9/dotfiles ~/.config || handle_error "Failed to clone the dotfiles repository."
ansible-playbook ~/.config/manifests/initialise.yml || handle_error "Failed to execute the Ansible playbook."
exit 0
