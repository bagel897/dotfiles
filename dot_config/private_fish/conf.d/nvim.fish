
function vimdiff
    nvim -d $1
end
set -g DIFFPROG "nvim -d $1"
