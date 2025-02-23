#!/bin/bash

# Make sure the correct environment is loaded
[ -f "HOME/venv/3.12/bin/activate" ] && source "HOME/venv/3.12/bin/activate"
export NVM_DIR="HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# set local bin in path
if [ -d "BIN_DIR" ] ; then
    PATH="BIN_DIR:$PATH"
fi

# remove duplicate entries
PATH="$(perl -e 'print join(":", grep { not $seen{$_}++  } split(/:/, $ENV{PATH}))')"
export PATH

# Use nvr to open files in the same instance if possible
if nvr --serverlist | grep -q vimsocket; then
  nvr --remote-tab "$@"
else
  cd ~/ansible/lxd/roles || cd ~
  exec BIN_DIR/neovide "$@" -- --listen /tmp/nvimsocket
fi
