#!/bin/bash	
if type -P nix-user-chroot > /dev/null; then
	if ! type -P nix > /dev/null; then
		nix-user-chroot ~/.nix bash ~/.local/share/chezmoi/nix_update.sh
	else
		bash ~/.local/share/chezmoi/nix_update.sh
	fi
else 
	fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fi
