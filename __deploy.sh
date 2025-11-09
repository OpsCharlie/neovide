#!/bin/bash
set -e 

BIN_DIR=~/.local/bin
[[ -d $BIN_DIR ]] || mkdir -p  $BIN_DIR

DIR=$(dirname "$(readlink -f "$0")")

curl -# https://github.com/neovide/neovide/releases/latest/download/neovide.AppImage -L -o $BIN_DIR/neovide
chmod +x $BIN_DIR/neovide

cd "$DIR" || exit

cp neovide-wrapper.sh $BIN_DIR/
sed -i "s|BIN_DIR|$BIN_DIR|g" $BIN_DIR/neovide-wrapper.sh
sed -i "s|HOME|$HOME|g" $BIN_DIR/neovide-wrapper.sh
chmod +x $BIN_DIR/neovide-wrapper.sh
cp neovide.desktop ~/.local/share/applications/
cp neovide.svg ~/.local/share/icons/

sed -i "s|BIN_DIR|$BIN_DIR|g" ~/.local/share/applications/neovide.desktop
sed -i "s|HOME|$HOME|g" ~/.local/share/applications/neovide.desktop
update-desktop-database ~/.local/share/applications/

if pip show neovim-remote > /dev/null 2>&1; then
    echo "nvr is already installed"
else
    echo "Installing nvr"
    pip install neovim-remote
    echo "Package is installed"
fi
