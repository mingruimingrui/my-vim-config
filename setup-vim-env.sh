#!/bin/sh
set -e

NVIM_CONFIG_DIR=$HOME/.config/nvim

# Check if Neovim is installed
[ $(command -v nvim) ] || (echo "neovim is needed" && exit 1)

# Check if curl is installed
[ $(command -v curl) ] || (echo "curl is needed" && exit 1)

# Install vim-plug
if [ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
    echo "Installing: vim-plug"
    curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "Skipped: vim-plug already installed"
fi

# Ensure nvim config directory exists
mkdir -p $NVIM_CONFIG_DIR

# Make a copy of current init.vim file
if [ -f $NVIM_CONFIG_DIR/init.vim ]; then
    for filename in $(find $NVIM_CONFIG_DIR/init.vim* | sort -r); do
        echo "Moving $filename to $filename.bak"
        mv $filename $filename.bak
    done
fi

# Copy init.vim to config directory
cp init.vim $NVIM_CONFIG_DIR/init.vim

# Install plugins
nvim +PlugClean +PlugUpgrade +PlugUpdate +qall
nvim +GoUpdateBinaries +qall

# Install

echo "Setup complete"
