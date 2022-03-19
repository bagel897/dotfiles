#!/bin/sh
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
fish -c "fisher update"
