function ls
    if type -q eza
        command eza $argv
    else
        echo "Eza is missing"
        command ls --color=auto $argv
    end
end
