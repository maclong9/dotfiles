#!/bin/sh
handle_error() {
  echo "An error occurred: $1"
  exit 1
}

install_command="xbps-install -y"

if [ "$1" = "-i" ]; then
  if [ -z "$2" ]; then
    handle_error "No install command provided."
  fi
  install_command="$2"
fi

case "$(uname -s)" in
  "Darwin")
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh || handle_error "Failed to install Homebrew."
    echo "eval \$($(brew --prefix)/bin/brew shellenv)" >> "$HOME/.zprofile" || handle_error "Failed to setup Homebrew environment."
    . "$HOME/.zprofile"
    brew install ansible || handle_error "Failed to install Ansible."
    ;;
  "Linux")
    sudo $install_command ansible || handle_error "Failed to install Ansible."
    ;;
  "OpenBSD")
    echo "OpenBSD support is in progress. Need to confirm tooling and best practices before adding it to initialization scripts"
    exit 0
    # sudo pkg_add ansible || handle_error "Failed to install Ansible."
    ;;
  *)
    handle_error "Unsupported system"
    ;;
esac

git clone https://github.com/mac-codes9/dotfiles ~/.config || handle_error "Failed to clone the dotfiles repository."
ansible-playbook ~/.config/manifests/initialise.yml || handle_error "Failed to execute the Ansible playbook."
exit 0
