#!/bin/bash -e

###########################################################################
# This file ensures files are mapped from ide_identity into ide_home.
# Fails if any required secret or configuration file is missing.
###########################################################################

# copy the directory with all the secrets, particulary id_rsa
if [ ! -d "${ide_identity}/.ssh" ]; then
  echo "WARN: ${ide_identity}/.ssh does not exist"
else
  cp -r "${ide_identity}/.ssh" "${ide_home}"
fi
if [ ! -f "${ide_identity}/.ssh/id_rsa" ]; then
  echo "WARN: ${ide_identity}/.ssh/id_rsa does not exist"
else
  for id_rsa_file in "${ide_home}/.ssh/"*"id_rsa"; do
    chown ide:ide "${id_rsa_file}"
    chmod 0600 "${id_rsa_file}"
  done
fi

# we need to ensure that ${ide_home}/.ssh/config contains at least:
# StrictHostKeyChecking no
echo "StrictHostKeyChecking no
UserKnownHostsFile /dev/null
ForwardAgent yes

Host git.ai-traders.com
User git
Port 2222
IdentityFile ${ide_home}/.ssh/id_rsa

Host gogs.ai-traders.com
User git
Port 2222
IdentityFile ${ide_home}/.ssh/id_rsa

Host gitlab.ai-traders.com
User git
Port 2222
IdentityFile ${ide_home}/.ssh/id_rsa
" > "${ide_home}/.ssh/config"

# not obligatory configuration file
if [ -f "${ide_identity}/.gitconfig" ]; then
  cp "${ide_identity}/.gitconfig" "${ide_home}"
fi

# Not obligatory file; in order to ensure that after bash login, the ide user
# is in /ide/work. Not obligatory but shortens end user's commands.
# Do not copy it from $ide_identity, because it may reference sth not installed in
# this docker image.
touch "${ide_home}/.profile"

echo "
# if running bash
if [ -n \"\$BASH_VERSION\" ]; then
    # include .bashrc if it exists
    if [ -f \"\$HOME/.bashrc\" ]; then
	. \"\$HOME/.bashrc\"
    fi
fi
cd \"\${ide_work}\"
" > "${ide_home}/.profile"
