return {
  {
    "nvim-lspconfig",
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      -- add any global capabilities here
      capabilities = {},
      -- Automatically format on save
      autoformat = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        taplo = {},
        clojure_lsp = {},
        -- prosemd_lsp ={},
        vimls = {},
        bashls = {},
        ruff_lsp = {},
        cmake = {},
        esbonio = {},
        gradle_ls = {},
        pylsp = {
          pylsp = {
            plugins = {
              pycodestyle = { enabled = true, maxLineLength = 88 },
              -- pydocstyle = { enabled = true },
              rope_autoimport = { enabled = true, memory = false },
              pylsp_mypy = {
                enabled = true,
                live_mode = false,
                dmypy = true,
                report_progress = true,
              },
              pylint = { enabled = true, args = { "--disable C0301" } },
            },
          },
        },

        marksman = {},
        dockerls = {},
        -- pyright ={},
        -- jedi_language_server ={},
        gdscript = {},
        groovyls = {},
        jsonls = {},
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}
