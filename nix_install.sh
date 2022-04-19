. ~/.nix-profile/etc/profile.d/nix.sh
nix-env -iA nixpkgs.neovim nixpkgs.fd nixpkgs.exa nixpkgs.fzf nixpkgs.ripgrep nixpkgs.delta nixpkgs.fish nixpkgs.git
nix-env -iA nixpkgs.nodePackages.bash-language-server
nix-env -iA nixpkgs.python310Packages.python-lsp-server
nix-env -iA nixpkgs.python310Packages.pylsp-mypy
nix-env -iA nixpkgs.python310Packages.python-lsp-black
nix-env -iA nixpkgs.python310Packages.pyls-isort
nix-env -iA nixos.chezmoi
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
