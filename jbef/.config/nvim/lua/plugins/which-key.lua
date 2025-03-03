return {
  "folke/which-key.nvim",

  config = function()
    local wk = require("which-key")
    ---@type UISymbols
    local ui = require("config.ui")

    -- make sure to run this code before calling setup()
    -- refer to the full lists at https://github.com/folke/which-key.nvim/blob/main/lua/which-key/plugins/presets/init.lua
    local presets = require("which-key.plugins.presets")
    presets.operators["v"] = nil

    wk.setup()

    wk.add({
      { "<leader>f", icon = ui.common.Telescope, group = "Telescope" },
      { "<leader>l", icon = ui.common.Code, group = "LSP" },
    })
  end,
}
