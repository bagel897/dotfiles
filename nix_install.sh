. ~/.nix-profile/etc/profile.d/nix.sh
nix-env -iA nixpkgs.myPackage
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
