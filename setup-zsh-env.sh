#!/bin/sh
set -e

# Check if shell is ZSH
if [ ! $ZSH_CUSTOM ]; then
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
git clone https://github.com/esc/conda-zsh-completion ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Copy zshrc
cp zsh/zshrc ~/.zshrc
