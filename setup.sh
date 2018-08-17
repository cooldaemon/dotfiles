#!/usr/bin/env fish

# You need install the Docker for Mac.
# https://store.docker.com/editions/community/docker-ce-desktop-mac

brew install ansible
ansible-playbook -i localhost, -c local ansible/playbook.yml

# asdf install python 3.7.0
# asdf global python 3.7.0
# pip install neovim
# pip install powerline-status
# asdf reshim python

# sh ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
# asdf install nodejs 10.8.0
# asdf global nodejs 10.8.0
