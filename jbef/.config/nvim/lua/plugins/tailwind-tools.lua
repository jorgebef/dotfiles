-- tailwind-tools.lua
local M = {
  "luckasRanarison/tailwind-tools.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  enabled = false,
}

function M.config()
  require("tailwind-tools").setup({
    ---@type TailwindTools.Option
    {
      document_color = {
        enabled = true, -- can be toggled by commands
        kind = "inline", -- "inline" | "foreground" | "background"
        inline_symbol = "󰝤 ", -- only used in inline mode
        debounce = 200, -- in milliseconds, only applied in insert mode
      },
      conceal = {
        enabled = false, -- can be toggled by commands
        min_length = nil, -- only conceal classes exceeding the provided length
        symbol = "󱏿", -- only a single character is allowed
        highlight = { -- extmark highlight options, see :h 'highlight'
          fg = "#38BDF8",
        },
      },
      custom_filetypes = {}, -- see the extension section to learn how it works
    },
    -- settings = {
    --   tailwindCSS = {
    --     classAttributes = { "class", "clsx", "cva", "className", "classList", "ngClass" },
    --     lint = {
    --       cssConflict = "warning",
    --       invalidApply = "error",
    --       invalidConfigPath = "error",
    --       invalidScreen = "error",
    --       invalidTailwindDirective = "error",
    --       invalidVariant = "error",
    --       recommendedVariantOrder = "warning",
    --     },
    --     validate = true,
    --     experimental = {
    --       classRegex = {
    --         -- "clsx\\(([^)]*)\\)",
    --         "clsx\\(([^)]*)\\)",
    --         "cva\\(([^)]*)\\)",
    --         -- "(?:'|\"|`)([^']*)(?:'|\"|`)",
    --       },
    --     },
    --   },
    -- },
  })
end

return M
