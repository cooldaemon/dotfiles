#!/usr/bin/env fish

brew install ansible
ansible-playbook -i localhost, -c local ansible/playbook.yml
