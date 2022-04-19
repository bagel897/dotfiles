#!/bin/bash

if type -P pacman > /dev/null; then
	if ! type -P paru > /dev/null; then
		sudo pacman -S --needed base-devel
		git clone https://aur.archlinux.org/paru.git
		cd paru
		makepkg -si
	fi
	paru -S --needed neovim python-lsp-all fd exa fzf ripgrep git-delta fisher
else 
	if ! type -P cargo > /dev/null; then
		curl https://sh.rustup.rs -sSf | sh
	fi
	if ! type -P nix-user-chroot > /dev/null; then
		cargo install nix-user-chroot
		mkdir -m 0755 ~/.nix
		nix-user-chroot ~/.nix bash -c "curl -L https://nixos.org/nix/install | bash"
	fi
	nix-user-chroot ~/.nix bash nix-install.sh 
fi
if ! type -P fisher > /dev/null; then
	if type -P fish > /dev/null; then
		fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
	fi
fi
