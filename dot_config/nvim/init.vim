call plug#begin('~/.vim/plugged')
Plug 'mfussenegger/nvim-jdtls'
Plug 'mfussenegger/nvim-fzy', {'branch':'main'}
Plug 'hrsh7th/cmp-nvim-lsp', {'branch':'main'}
Plug 'neoclide/coc.nvim',{'branch':'release'}
Plug 'liuchengxu/eleline.vim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-dispatch'
Plug 'puremourning/vimspector'
call plug#end()
nnoremap <leader>v <cmd>CHADopen<cr>
lua require('jdtls.ui').pick_one_async = require('fzy').pick_one
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set copyindent
set laststatus=2
set updatetime=300
