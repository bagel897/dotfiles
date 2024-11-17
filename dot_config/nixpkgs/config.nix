{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
		pkgs.neovim
		pkgs.fd
		pkgs.eza
		pkgs.fzf
		pkgs.ripgrep
    pkgs.du-dust
    # pkgs.btop
    pkgs.mold
    pkgs.gh
		pkgs.delta
		pkgs.fish
		pkgs.git
		pkgs.bat
		pkgs.sccache
		pkgs.chezmoi
		pkgs.topgrade
		pkgs.difftastic
      ];
    };
  };
}

