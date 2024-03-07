#!/bin/sh
pip3 install ansible
export PATH=$PATH:/Users/mac/Library/Python/3.9/bin/
echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zprofile
ansible-playbook ~/.config/initialise.yml
