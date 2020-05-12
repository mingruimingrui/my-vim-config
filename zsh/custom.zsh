
unsetopt share_history
unsetopt BEEP

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

if [ $(command -v nvim) ]; then
	alias vim=nvim

	function install-nvim-py-pkgs() {
		pip install --no-cache-dir neovim jedi
	}
fi

CONDA_INIT_PATH=$HOME/miniconda3/etc/profile.d/conda.sh
if [ -f $CONDA_INIT_PATH ]; then
	. $CONDA_INIT_PATH
fi

