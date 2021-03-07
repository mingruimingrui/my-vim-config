#!/bin/sh

# Check if required packages are installed
[ $(command -v git) ] || (echo "git is needed" && exit 1)
[ $(command -v curl) ] || (echo "curl is needed" && exit 1)

# Download my-vim-config into ~/.my-vim-config
MY_VIM_CONFIG_DIR=~/.my-vim-config
git clone https://github.com/mingruimingrui/my-vim-config.git $MY_VIM_CONFIG_DIR

# Install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -o --unattended
fi

# Make a copy of current .zshrc file
if [ -f ~/.zshrc ]; then
    for filename in $(find ~/.zshrc* | sort -r); do
        echo "Moving $filename to $filename.bak"
        mv $filename $filename.bak
    done
fi

# Install oh-my-zsh dependecies
# - conda_zsh_completion
# - zsh_autosuggestions
# - zsh_syntax_highlighting

# CONDA_ZSH_COMPLETION_DIR=${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion
# if [ ! -d $CONDA_ZSH_COMPLETION_DIR ]; then
# 	git clone https://github.com/esc/conda-zsh-completion $CONDA_ZSH_COMPLETION_DIR
# fi

ZSH_AUTOSUGGESTIONS_DIR=${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [ ! -d $ZSH_AUTOSUGGESTIONS_DIR ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_AUTOSUGGESTIONS_DIR
fi

ZSH_SYNTAX_HIGHLIGHTING_DIR=${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ ! -d $ZSH_SYNTAX_HIGHLIGHTING_DIR ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_SYNTAX_HIGHLIGHTING_DIR
fi

# Symlink zsh files
ln -s ~/
cp $MY_VIM_CONFIG_DIR/zsh/zshrc ~/.zshrc
cp $MY_VIM_CONFIG_DIR/zsh/custom.zsh ~/.oh-my-zsh/custom

echo "ZSH setup complete"

# Check if neovim exists else exit 0
[ $(command -v nvim) ] || (exit 0)

# Nvim config dir
NVIM_CONFIG_DIR=$HOME/.config/nvim
mkdir -p $NVIM_CONFIG_DIR

# Install vim-plug
if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
    echo "Installing: vim-plug"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Make a copy of current init.vim file
if [ -f $NVIM_CONFIG_DIR/init.vim ]; then
    for filename in $(find $NVIM_CONFIG_DIR/init.vim* | sort -r); do
        echo "Moving $filename to $filename.bak"
        mv $filename $filename.bak
    done
fi

# Symlink init.vim
ln -s $MY_VIM_CONFIG_DIR/nvim/init.vim $NVIM_CONFIG_DIR/init.vim

# Install plugins
nvim +PlugClean +PlugUpgrade +PlugUpdate +qall
nvim +GoUpdateBinaries +qall

echo "Neovim setup complete"
