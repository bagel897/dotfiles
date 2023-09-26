#!/bin/bash

if type -P pacman >/dev/null; then
	if ! type -P paru >/dev/null; then
		sudo pacman -S --needed base-devel
		git clone https://aur.archlinux.org/paru.git
		cd paru
		makepkg -si
	fi
	paru -S --needed neovim fd exa fzf ripgrep git-delta python-pipx topgrade
else
	if type -P dnf >/dev/null; then
		echo "Skipping, on fedora"
	else
		export RUSTUP_HOME=$HOME/.local/share/rustup
		export CARGO_HOME=$HOME/.local/share/cargo
		export PATH=$PATH:~/.local/bin:"${CARGO_HOME}/bin/"
		if ! type -P cargo >/dev/null; then
			curl https://sh.rustup.rs -sSf | sh
		fi
		source $CARGO_HOME/env
		if ! type -P nix-user-chroot >/dev/null; then
			cargo install nix-user-chroot
			mkdir -m 0755 ~/.nix
			nix-user-chroot ~/.nix bash -c "curl -L https://nixos.org/nix/install | bash"
		fi
		if ! type -P nix >/dev/null; then
			nix-user-chroot ~/.nix bash ~/.local/share/chezmoi/nix_install.sh
		else
			bash ~/.local/share/chezmoi/nix_install.sh
		fi
	fi
fi
