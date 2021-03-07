unsetopt share_history
unsetopt BEEP

function add-to-path() {
    if [[ "$PATH" != ?(*:)"$1"?(:*) ]]; then
        export PATH=$1:$PATH
    fi
}

######## Locale

export LESSCHARSET=utf-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

######## Local packages

add-to-path "$HOME/.local/bin"
if [[ -d $HOME/.local/bins ]]; then
	for dirname in $(ls $HOME/.local/bins); do
		dirpath=$HOME/.local/bins/$dirname
		add-to-path $dirpath
	done
fi

######## Brew

if [ $(command -v brew) ]; then
	function brew-upgrade-clean() {
		brew update
		brew upgrade
		brew missing
		brew doctor
		brew bundle dump
		brew bundle --force cleanup
		brew cleanup
	}
fi

######## Conda
# Conda is my perferred method to run python

CONDA_INIT_PATH=$HOME/miniconda3/etc/profile.d/conda.sh
if [ -f $CONDA_INIT_PATH ]; then
	. $CONDA_INIT_PATH
	function conda-upgrade-base() {
		conda update -n base -c defaults conda
	}
fi

######## Go
# I usually install go locally under $HOME/.local/go

add-to-path "$HOME/.local/go/bin"

######## Neovim
# Neovim's my editor of choice

if [ $(command -v nvim) ]; then
	alias vim=nvim
	function install-nvim-py-pkgs() {
		pip install --no-cache-dir neovim jedi==0.17.2
	}
fi

######## SSH and rsync

alias rsync="rsync --cvs-exclude --max-size=10m"
function tunnel() {
	ssh -NL "localhost:$2":"localhost:$2" $1
}
function upsync() {
	SERVER=$1
	DESTDIR=$2

	if [ -z $SERVER ]; then
		echo "Usage: upsync SERVER DESTDIR=Projects"
		return
	fi

	if [ -z $DESTDIR ]; then
		DESTDIR=Projects
	fi

	rsync -L -r --cvs-exclude --max-size=10m \
		. $SERVER:$DESTDIR/$(basename $PWD)
}
