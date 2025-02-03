#!/bin/bash

[[ -d ~/bin ]] || mkdir ~/bin

DIR=$(dirname "$(readlink -f "$0")")

curl -s https://github.com/neovide/neovide/releases/latest/download/neovide.AppImage -L -o ~/bin/neovide
chmod +x ~/bin/neovide

cd "$DIR" || exit

cp neovide-wrapper.sh ~/bin/
chmod +x ~/bin/neovide-wrapper.sh
cp neovide.desktop ~/.local/share/applications/
cp neovide.svg ~/.local/share/icons/

update-desktop-database ~/.local/share/applications/

if pip show neovim-remote > /dev/null 2>&1; then
    echo "nvr is already installed"
else
    echo "Installing nvr"
    pip install neovim-remote
    echo "Package is installed"
fi
