#curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher!/bin/bash

if ! type -P nvim > /dev/null; then
	if [ ! -d ~/.local/bin ]; then
		mkdir ~/.local/bin
	fi
	echo Downloading latest neovim appimage...
	curl -sSL https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > /tmp/nvim.appimage
	chmod a+x /tmp/nvim.appimage
	echo Copying to ~/.local/bin/nvim
	mv /tmp/nvim.appimage ~/.local/bin/nvim
fi
if ! type -P cargo > /dev/null; then
	curl https://sh.rustup.rs -sSf | sh
fi
if ! type -P pylsp > /dev/null; then
	pip install pylsp-rope python-lsp-server[all] python-lsp-black pylsp-mypy
fi
if ! type -P fd > /dev/null; then 
	cargo install fd-find
fi
if ! type -P fzf > /dev/null; then 
	cargo install fzf
fi
if ! type -P rg > /dev/null; then 
	cargo install rg
fi
if ! type -P fisher > /dev/null; then
	if type -P fish > /dev/null; then
		fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
	fi
fi
