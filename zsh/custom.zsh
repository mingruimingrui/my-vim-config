
unsetopt share_history
unsetopt BEEP

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

######## Python

CONDA_INIT_PATH=$HOME/miniconda3/etc/profile.d/conda.sh
if [ -f $CONDA_INIT_PATH ]; then
	. $CONDA_INIT_PATH
	function conda-upgrade-base() {
		conda update -n base -c defaults conda
	}
fi

######## Neovim

if [ $(command -v nvim) ]; then
	alias vim=nvim
	function install-nvim-py-pkgs() {
		pip install --no-cache-dir neovim jedi
	}
fi

######## SSH and sync

alias rsync="rsync --cvs-exclude --max-size=10m"
function tunnel() {
	ssh -NL "localhost:$2":"localhost:$2" $1
}

######## Local packages

if [[ "$PATH" == ?(*:)"$HOME/.local/bin"?(:*) ]]; then
	export PATH=$HOME/.local/bin:$PATH
fi
