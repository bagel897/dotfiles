return {
  "saghen/blink.cmp",
  dependencies = {
    "Kaiser-Yang/blink-cmp-avante",
    -- ... Other dependencies
  },
  ---@param opts blink.ConfigSchema
  opts = function(_, opts)
    table.insert(opts.sources.default, "avante")
    opts.sources.providers = vim.tbl_extend("force", opts.sources.providers, {
      avante = {
        module = "blink-cmp-avante",
        name = "Avante",
        opts = {
          -- options for blink-cmp-avante
        },
      },
    })
  end,
}
