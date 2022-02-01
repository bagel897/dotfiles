nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
lua require('plugins')
let g:coq_settings = { 'auto_start': 'shut-up' }
lua require('lsp')
lua require('opt')
" nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
" nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
" vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
" nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

" autocmd CursorHold,CursorHoldI * lua require('code_action_utils').code_action_listener()
