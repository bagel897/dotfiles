#zoxide init  fish | source
if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end
fundle plugin "ryoppippi/fish-poetry"
fundle plugin "2m/fish-history-merge"
fundle plugin "IlanCosman/tide"
fundle plugin "PatrickF1/fzf.fish"
fundle plugin "sentriz/fish-pipenv"
# fundle plugin "gazorby/fifc"
fundle init
export DENO_INSTALL="/home/bageljr/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

set -Ux fifc_editor $EDITOR
set -U fifc_fd_opts --hidden
set -gp PATH  /home/bageljr/.local/bin
set fish_greeting
set -g VDPAU_DRIVER radeonsi
set -g LIBVA_DRIVER_NAME radeonsi
set -ga NIX_PATH "REPEAT=/dev/null"
set -g XDG_DATA_HOME "$HOME/.local/share"
set -g XDG_CONFIG_HOME "$HOME/.config"
set -g AWS_SHARED_CREDENTIALS_FILE "$XDG_CONFIG_HOME/aws/credentials" 
set -g AWS_CONFIG_FILE "$XDG_CONFIG_HOME/aws/config" 
set -g BASH_COMPLETION_USER_FILE "$XDG_CONFIG_HOME"/bash-completion/bash_completion
set -g CONDARC "$XDG_CONFIG_HOME/conda/condarc"
set -g CARGO_HOME "$XDG_DATA_HOME/cargo"
set -g DOCKER_CONFIG "$XDG_CONFIG_HOME"/docker
set -g GTK2_RC_FILES "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
set -g IPFS_PATH "$XDG_DATA_HOME"/ipfs
set -g JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME"/jupyter
set -g KDEHOME "$XDG_CONFIG_HOME"/kde 
set -g _JAVA_OPTIONS -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

set fzf_preview_dir_cmd exa --all --color=always
alias 'vim'=$EDITOR
alias 'ls'=exa
alias 'grep'=rg
alias 'du'=dust
alias 'cat'="bat -p -p"
alias 'find'=fd
alias diff='diff --color=auto'
alias ip='ip -color=auto'
#alias 'cd'=z
if test -n "$PYTHONPATH"
    set -x PYTHONPATH '/home/bageljr/.local/pipx/venvs/pdm/lib/python3.10/site-packages/pdm/pep582' $PYTHONPATH
else
    set -x PYTHONPATH '/home/bageljr/.local/pipx/venvs/pdm/lib/python3.10/site-packages/pdm/pep582'
end
function java-gui
    java --module-path /usr/lib/jvm/java-11-openjfx/lib --add-modules javafx.controls,javafx.fxml,javafx.web $argv
end
function dmesg
    sudo dmesg | grep -v audit | grep -v swap
end
function windows
    sudo bootctl set-oneshot auto-windoes
    sudo reboot
end
function fishrc
    chezmoi edit --apply ~/.config/fish/config.fish
end
function neovimrc
    chezmoi edit --apply ~/.config/nvim/init.vim
end
function ros
    docker exec -it ros bash
end
function ros-stop
    docker container stop ros
    docker container rm ros
end
function ros-start
    ros-stop
    cd ~/code/hart/docker
    podman-compose build
    podman-compose up -d
    ros
end
function compile_cmake
  cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
  ln -s Debug/compile_commands.json .
end
function vimdiff
    nvim -d $1
end
set -g DIFFPROG "nvim -d $1"
# eval "$(pdm --pep582)"
