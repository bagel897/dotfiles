#!/bin/bash	
if type -P nix-user-chroot > /dev/null; then
	if ! type -P nix > /dev/null; then
		nix-user-chroot ~/.nix bash nix_install.sh
	else
		bash ~/.local/share/chezmoi/nix_install.sh
	fi
fi
