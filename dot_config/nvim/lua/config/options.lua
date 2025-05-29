-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.wrap = true
vim.g.root_spec = { { ".git", "lua" }, "lsp", "cwd" }
vim.api.nvim_set_option("clipboard", "unnamedplus")
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end
vim.api.nvim_create_user_command("MasonUpgrade", function()
  local registry = require("mason-registry")
  registry.refresh()
  registry.update()
  local packages = registry.get_all_packages()
  for _, pkg in ipairs(packages) do
    if pkg:is_installed() then
      pkg:install()
    end
  end
  vim.cmd("doautocmd User MasonUpgradeComplete")
end, { force = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("autoupdate"),
  callback = function()
    if require("lazy.status").has_updates then
      require("lazy").update({ show = false })
    end
    vim.cmd(":TSUpdate")
    -- vim.cmd(":MasonUpgrade")
  end,
})
