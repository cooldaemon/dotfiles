#!/usr/bin/env fish

brew install ansible
brew install peco
ansible-playbook -i localhost, -c local ansible/playbook.yml
