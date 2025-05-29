return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pylsp = { mason = false, settings = { rope_autoimport = { enabled = true } } },
    },
  },
  enabled = false,
}
