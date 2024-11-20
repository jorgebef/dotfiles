local M = {
  "lukas-reineke/indent-blankline.nvim",
  enabled = false,
}

function M.config()
  -- local cp = require("catppuccin.palettes").get_palette("mocha")
  -- local c = require("tokyonight.colors").setup()
  local ibl = require("ibl")

  -- vim.g.indent_blankline_context_patterns = {
  --   "declaration",
  --   "expression",
  --   "pattern",
  --   "primary_expression",
  --   "statement",
  --   "switch_body",
  --   "function",
  --   "jsx_attribute",
  --   "jsx_closing_element",
  --   "jsx_element",
  --   "jsx_expression",
  --   "jsx_fragment",
  --   "jsx_namespace_name",
  --   "jsx_opening_element",
  --   "jsx_self_closing_element",
  -- }
  --
  -- ibl.setup({
  --   -- char = "|",
  --   buftype_exclude = {
  --     "terminal",
  --   },
  --   filetype_exclude = {
  --     "startify",
  --     "dashboard",
  --     "help",
  --     "NvimTree",
  --     "lspsagafinder",
  --     "packer",
  --     "mason",
  --     "lazy",
  --     "noice",
  --   },
  --   -- space_char_blankline = " ",
  --   show_current_context = true,
  --   -- show_current_context = false,
  --   -- show_current_context_start = true,
  -- })

  ibl.setup({
    exclude = {
      buftypes = {
        "terminal",
        "filesystem",
      },
      filetypes = {
        "startify",
        "dashboard",
        "help",
        "NvimTree",
        "lspsagafinder",
        "neo-tree",
        "packer",
        "mason",
        "lazy",
        "noice",
      },
    },
    indent = { char = "│" },
    scope = {
      show_start = false,
      show_end = false,
    },
  })
end

return M
