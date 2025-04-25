return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup({
      completion = {
        menu = {
          auto_show = function(ctx)
            return ctx.mode ~= "default"
          end,
        },
      },
    })
    vim.keymap.set("i", "<Tab>", neocodeium.accept)
    local blink = require("blink.cmp")

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      callback = function()
        neocodeium.clear()
      end,
    })

    neocodeium.setup({
      filter = function()
        return not blink.is_visible()
      end,
    })
  end,
  enabled = false,
}
