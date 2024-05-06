-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("DapLoadLaunchJS"),
  callback = function()
    require("dap.ext.vscode").load_launchjs()
  end,
})
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
vim.cmd(":TSUpdate")
vim.cmd(":MasonUpgrade")
