# nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerCompile'
. ~/.nix-profile/etc/profile.d/nix.sh
fish -c "fisher update > /dev/null"
nix-channel --update
nix-env -u '*'
