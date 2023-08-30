local config = function()
  local dap = require("dap")

  dap.adapters.firefox = {
    type = "executable",
    command = "node",
    args = {
      os.getenv("HOME") .. "/.local/share/nvim/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js",
    },
  }
  dap.configurations.typescript = {
    {
      name = "Debug with Firefox",
      type = "firefox",
      request = "launch",
      reAttach = true,
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
    },
  }
  local mappings = { codelldb = { "c", "cpp" }, firefox = { "typescript", "javascript" } }

  require("dap.ext.vscode").load_launchjs(nil, mappings)

  -- vim.cmd([[autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif]])
end
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "Joakker/lua-json5",
      build = "./install.sh",
      config = function()
        require("dap.ext.vscode").json_decode = require("json5").parse
      end,
    },
    { "overseer.nvim" },
    {
      "nvim-telescope/telescope-dap.nvim",
      config = function()
        require("telescope").load_extension("dap")
      end,
    },
    {
      -- Ensure Python debugger is installed
      "williamboman/mason.nvim",
      optional = true,
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "debugpy", "firefox-debug-adapter" })
        end
      end,
    },

    {
      "hrsh7th/nvim-cmp",
      dependencies = { "rcarriga/cmp-dap" },
      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        local cmp = require("cmp")
        opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "dap" } }))
      end,
    },

    { "Weissle/persistent-breakpoints.nvim", opts = { load_breakpoints_event = { "BufReadPost" } } },
  },
  config = config,
}
