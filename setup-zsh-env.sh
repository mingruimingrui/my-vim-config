#!/bin/sh
set -e

# Check if oh my zsh is installed
if [ ! -z $ZSH_CUSTOM ]; then
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Make a copy of current .zshrc file
if [ -f $HOME/.zshrc ]; then
    for filename in $(find $HOME/.zshrc* | sort -r); do
        echo "Moving $filename to $filename.bak"
        mv $filename $filename.bak
    done
fi

# Install dependecies
CONDA_ZSH_COMPLETION_DIR=${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion
if [ ! -d $CONDA_ZSH_COMPLETION_DIR ]; then
	git clone https://github.com/esc/conda-zsh-completion $CONDA_ZSH_COMPLETION_DIR
fi

ZSH_AUTOSUGGESTIONS_DIR=${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [ ! -d $ZSH_AUTOSUGGESTIONS_DIR ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_AUTOSUGGESTIONS_DIR
fi

ZSH_SYNTAX_HIGHLIGHTING_DIR=${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ ! -d $ZSH_SYNTAX_HIGHLIGHTING_DIR ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_HIGHLIGHTING_DIR
fi

# Copy zshrc files
cp zsh/zshrc ~/.zshrc
cp zsh/custom.zsh ~/.oh-my-zsh/custom
