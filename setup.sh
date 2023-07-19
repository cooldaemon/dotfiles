#!/usr/bin/env bash

# https://docs.brew.sh/Installation
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

eval "$(/opt/homebrew/bin/brew shellenv)"

brew install ansible
ansible-playbook -i localhost, -c local ansible/playbook.yml

echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells