#!/bin/bash -e

###########################################################################
# This file ensures files are mapped from dojo_identity into dojo_home.
# Fails if any required secret or configuration file is missing.
###########################################################################

# copy the directory with all the secrets, particulary id_rsa
if [ ! -d "${dojo_identity}/.ssh" ]; then
  echo "WARN: ${dojo_identity}/.ssh does not exist"
else
  cp -r "${dojo_identity}/.ssh" "${dojo_home}"
  # we need to ensure that ${dojo_home}/.ssh/config contains at least:
  # StrictHostKeyChecking no
  echo "StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
  ForwardAgent yes
  " > "${dojo_home}/.ssh/config"
  if [ ! -f "${dojo_identity}/.ssh/id_rsa" ]; then
    echo "WARN: ${dojo_identity}/.ssh/id_rsa does not exist"
  else
    for id_rsa_file in "${dojo_home}/.ssh/"*"id_rsa"; do
      chmod 0600 "${id_rsa_file}"
    done
  fi
  chown dojo:dojo -R "${dojo_home}/.ssh"
fi

# not obligatory configuration file
if [ -f "${dojo_identity}/.gitconfig" ]; then
  cp "${dojo_identity}/.gitconfig" "${dojo_home}"
  chown dojo:dojo "${dojo_home}/.gitconfig"
fi
