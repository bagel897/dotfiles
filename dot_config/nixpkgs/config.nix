{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
		pkgs.neovim
		pkgs.fd
		pkgs.exa
		pkgs.fzf
		pkgs.ripgrep
		pkgs.delta
		pkgs.fish
		pkgs.nodePackages.bash-language-server
		pkgs.python310Packages.python-lsp-server
		pkgs.mypy
		pkgs.git
		pkgs.fish
		pkgs.bat
		pkgs.sccache
		# pkgs.pip
		pkgs.chezmoi
		pkgs.poetry
		pkgs.tree-sitter.allGrammars
		# pkgs.python310Packages.pylsp-mypy
		pkgs.python310Packages.python-lsp-black
                pkgs.python310Packages.pyls-isort
      ];
    };
  };
}

