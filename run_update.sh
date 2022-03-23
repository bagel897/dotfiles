#!/bin/sh
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
if type -p fish > /dev/null; then
	fish -c "fisher update > /dev/null"
fi
