#zoxide init  fish | source
if not functions -q fundle
    eval (curl -sfL https://git.io/fundle-install)
end
fundle plugin ryoppippi/fish-poetry
fundle plugin 2m/fish-history-merge
fundle plugin IlanCosman/tide
fundle plugin "PatrickF1/fzf.fish"
fundle plugin sentriz/fish-pipenv
fundle plugin franciscolourenco/done
# fundle plugin "gazorby/fifc"
fundle init
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

set -Ux fifc_editor $EDITOR
set -U fifc_fd_opts --hidden
set -gxp PATH $HOME/.local/bin
set -gxp PATH $HOME/.local/share/bob/nvim-bin
set fish_greeting
set -gx VDPAU_DRIVER radeonsi
set -gx LIBVA_DRIVER_NAME radeonsi
set -gxa NIX_PATH "REPEAT=/dev/null"
set fzf_preview_dir_cmd eza --all --color=always
alias 'vim'=$EDITOR
alias 'grep'=rg
alias 'du'=dust
alias 'cat'="bat -p -p"
alias 'find'=fd
alias 'man'=batman
alias diff='diff --color=auto'
alias ip='ip -color=auto'
#alias 'cd'=z
function dmesg
    sudo dmesg | grep -v audit | grep -v swap
end
function windows
    sudo bootctl set-oneshot auto-windoes
    sudo reboot
end
# eval "$(pdm --pep582)"
