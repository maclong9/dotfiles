#!/bin/sh
# Check System & Configure Accordingly
if [ "$(uname -s)" ]; then
  echo "Running on macOS"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zprofile
elif [ "$(uname)" = "OpenBSD" ]; then
  echo "Running on BSD"
  apk add python3
elif [ -f /etc/void-release ]; then
  echo "Running on Linux"
  xbps-install python3
fi

# Install Ansible
pip3 install ansible
export PATH=$PATH:/Users/mac/Library/Python/3.9/bin/

# Clone Configuration & Run Ansible Playbook
git clone https://github.com/mac-codes9/dotfiles ~/.config
ansible-playbook ~/.config/initialise.yml
