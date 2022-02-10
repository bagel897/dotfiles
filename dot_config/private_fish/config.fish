#zoxide init  fish | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
set pipenv_fish_fancy yes
set -g theme_nerd_fonts yes
set -g theme_display_date yes
set -g VDPAU_DRIVER radeonsi
set -g LIBVA_DRIVER_NAME radeonsi
set fzf_preview_dir_cmd exa --all --color=always
alias 'vim'=$EDITOR
alias 'ls'=exa
alias 'grep'=rg
alias 'du'=dust
alias 'cat'="bat -p -p"
alias 'find'=fd
#alias 'sudo'='sudo '
alias diff='diff --color=auto'
alias ip='ip -color=auto'
alias bpytop="btop"
#alias 'cd'=z
#set sudo 'sudo '
function java-gui
    java --module-path /usr/lib/jvm/java-11-openjfx/lib --add-modules javafx.controls,javafx.fxml,javafx.web $argv
end
function dmesg
    sudo dmesg | grep -v audit | grep -v swap
end
function pulseeffects-restart
    killall pulseeffects
    systemctl --user restart app-pulseeffects\\x2dservice@autostart.service
end    
function pipewire-restart
    systemctl --user restart pipewire
    killall electron
    systemctl --user restart app-discord@autostart.service
    pulseeffects-restart
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
function update
    paru
    flatpak update
    chezmoi update
end
function compile_cmake
  cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
  ln -s Debug/compile_commands.json .
end
set -g DEBUGINFOD_URLS "https://debuginfod.elfutils.org/"
set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")

thefuck --alias | source
status is-login; and pyenv init --path | source
status is-interactive; and pyenv init - | source
