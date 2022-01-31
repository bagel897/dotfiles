local M = {}
local dap =  require'dap'

function M.reload_continue()
  package.loaded['dap_setup'] = nil
  require('dap_setup')
  dap.continue()
end

require('dap_setup')
local opts = { noremap=false, silent=true }

vim.api.nvim_buf_set_keymap( 0, 'n', '<Leader>dn',
       '<cmd>lua require"dap".step_over()<CR>', opts)
vim.api.nvim_buf_set_keymap( 0, 'n', '<Leader>ds',
       '<cmd>lua require"dap".step_into()<CR>', opts)
vim.api.nvim_buf_set_keymap( 0, 'n', '<Leader>do',
       '<cmd>lua require"dap".step_out()<CR>', opts)
vim.api.nvim_buf_set_keymap( 0, 'n', '<Leader>db',
       '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
-- vim.api.nvim_buf_set_keymap( 0, 'n', '<Leader>dB',
--        '<cmd>lua require"dap".set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>', opts)
vim.api.nvim_buf_set_keymap( 0, 'n', '<Leader>dc',
       '<cmd>lua require"dap".continue()<CR>', opts)

vim.api.nvim_buf_set_keymap( 0, 'n', '<Leader>dr',
       '<cmd>lua require"dap".run_last()<CR>', opts)
-- <Leader>eC to reload and then continue
vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>dl',
    '<cmd>lua require"dap_util".reload_continue()<CR>', opts)

return M
