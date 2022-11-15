#!/bin/bash	
if type -P nix > /dev/null; then
	bash ~/.local/share/chezmoi/nix_update.sh
else if type -P nix-user-chroot > /dev/null; then
      nix-user-chroot ~/.nix bash ~/.local/share/chezmoi/nix_update.sh
fi fi
