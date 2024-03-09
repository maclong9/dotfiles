#!/bin/sh
if [ "$(uname -s)" ]; then
  echo "Running on macOS"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zprofile
  . $HOME/.zprofile
  brew install ansible
elif [ -f /etc/void-release ]; then
  echo "Running on Linux"
  xbps-install ansible
else
  echo "Unsupported system, exiting"
  exit 1
fi

git clone https://github.com/mac-codes9/dotfiles ~/.config
ansible-playbook ~/.config/manifests/initialise.yml
exit 0
