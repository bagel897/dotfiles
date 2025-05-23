-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.wrap = true
vim.g.root_spec = { { ".git", "lua" }, "lsp", "cwd" }
if require("lazy.status").has_updates then
  require("lazy").update({ show = false })
end
