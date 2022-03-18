#!/bin/bash

if ! type -P nvim; then
	if [ ! -d ~/.local/bin ]; then
		mkdir ~/.local/bin
	fi
	echo Downloading latest neovim appimage...
	curl -sSL https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > /tmp/nvim.appimage
	chmod a+x /tmp/nvim.appimage
	echo Copying to ~/.local/bin/nvim
	mv /tmp/nvim.appimage ~/.local/bin/nvim
fi
if ! type -P pylsp; then
	pip install pylsp-rope python-lsp-server[all] python-lsp-black pylsp-mypy
fi
if ! type -P fd; then 
	if ! type -P cargo; then
		cargo install fd
	fi
fi
if ! type -P fzf; then 
	if ! type -P cargo; then
		cargo install fzf
	fi
fi
