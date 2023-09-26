set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_STATE_HOME $HOME/.local/state/
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx AWS_SHARED_CREDENTIALS_FILE "$XDG_CONFIG_HOME/aws/credentials"
set -gx AWS_CONFIG_FILE "$XDG_CONFIG_HOME/aws/config"
set -gx BASH_COMPLETION_USER_FILE "$XDG_CONFIG_HOME"/bash-completion/bash_completion
set -gx CONDARC "$XDG_CONFIG_HOME/conda/condarc"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME"/docker
set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
set -gx IPFS_PATH "$XDG_DATA_HOME"/ipfs
set -gx JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME"/jupyter
set -gx KDEHOME "$XDG_CONFIG_HOME"/kde
set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
set -gx EDITOR nvim
set -gx GOPATH "$XDG_DATA_HOME"/go
set -gx GOMODCACHE "$XDG_CACHE_HOME"/go/mod
export ZDOTDIR="$HOME"/.config/zsh
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export HISTFILE="$XDG_STATE_HOME"/zsh/history
# export SSB_HOME="$XDG_DATA_HOME"/zoom
export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"
export ANDROID_HOME="$XDG_DATA_HOME"/android
export CCACHE_DIR="$XDG_CACHE_HOME"/ccache
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
alias gdb="gdb -n -x $XDG_CONFIG_HOME/gdb/init```"
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export XCURSOR_PATH=/usr/share/icons:"$XDG_DATA_HOME"/icons
export IPFS_PATH="$XDG_DATA_HOME"/ipfs
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
