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
		pkgs.git
		pkgs.fish
		pkgs.bat
		pkgs.sccache
		pkgs.chezmoi
		pkgs.poetry
		pkgs.tree-sitter.allGrammars
		pkgs.topgrade
      ];
    };
  };
}

