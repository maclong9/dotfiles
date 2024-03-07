#!/bin/sh

# Check System & Configure Accordingly
if [ -f /etc/void-release ]; then
  xbps-install python3
elif [ "$(uname -s)" ]; then
  echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zprofile
fi

# Setup Ansible
pip3 install ansible
export PATH=$PATH:/Users/mac/Library/Python/3.9/bin/

# Clone Configuration & Run Ansible Playbook
git clone https://github.com/mac-codes9/dotfiles ~/.config
ansible-playbook ~/.config/initialise.yml
