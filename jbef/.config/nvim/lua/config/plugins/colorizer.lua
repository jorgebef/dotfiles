local M = {
  -- "NvChad/nvim-colorizer.lua",
  "mehalter/nvim-colorizer.lua",
  branch = "master",
} -- Colorizer

function M.config()
  -- ===================================================================
  -- This is for NvChad/colorizer fork
  -- It has the virtualtext option, but needs optimizing
  -- ===================================================================
  require("colorizer").setup({
    filetypes = { "*", "!lazy", "!TelescopePrompt" },
    user_default_options = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = true, -- "Name" codes like Blue or blue
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      AARRGGBB = true, -- 0xAARRGGBB hex codes
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes for `mode`: foreground, background,  virtualtext
      -- mode = "background", -- Set the display mode.
      -- mode = "virtualtext", -- Set the display mode.
      mode = "inline", -- Set the display mode.
      -- Available methods are false / true / "normal" / "lsp" / "both"
      -- True is same as normal
      tailwind = true, -- Enable tailwind colors
      -- parsers can contain values used in |user_default_options|
      -- sass = { enable = false, parsers = { css } }, -- Enable sass colors
      virtualtext = " ",
    },
    -- all the sub-options of filetypes apply to buftypes
    buftypes = {
      "*",
      -- exclude prompt and popup buftypes from highlight
      "!prompt",
      "!popup",
    },
  })

  vim.keymap.set(
    "n",
    "<leader>cr",
    ":ColorizerDetachFromBuffer<cr> | :ColorizerAttachToBuffer<cr>",
    { noremap = true, silent = true, nowait = true }
  )
end

return M
