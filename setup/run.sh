#!/bin/sh
handle_error() {
  echo "An error occurred: $1"
  exit 1
}

case "$(uname -s)" in
  "Darwin")
    pip3 install ansible || handle_error "Failed to install Ansible"
    ;;
  "Linux")
    xbps-install ansible git || handle_error "Failed to install Ansible."
    ;;
  *)
    handle_error "Unsupported system"
    ;;
esac

git clone https://github.com/maclong9/dotfiles ~/.config || handle_error "Failed to clone the dotfiles repository."
ansible-playbook ~/.config/setup/initialise.yml --ask-become-password || handle_error "Failed to execute the Ansible playbook."
exit 0
