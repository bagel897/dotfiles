local on_attach = require("configs.on_attach_ih")
local root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1])
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local lombok_path = "$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar"
-- string concattenation in Lua- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    "jdtls",
    "--jvm-arg=-javaagent:" .. lombok_path .. "=ECJ",
    "--jvm-arg=-Dlog.level=ALL",

    "-data",
    "$HOME/.cache/jdtls/" .. project_name,
  },
  root_dir = root_dir,
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {},
  },
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {
      vim.fn.glob(
        "~/.local/share/nvim/mason/packages/java-test/extension/server/com.microsoft.java.debug.plugin-*.jar",
        1
      ),
      vim.fn.glob("~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/*.jar", 1),
    },
  },
  on_attach = function(client, buffer)
    on_attach(client, buffer)
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    require("jdtls.setup").add_commands()
  end,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
