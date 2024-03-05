local M = { "nvim-lualine/lualine.nvim" }

function M.config()
  local ui = require("config.ui")
  local cp = require("catppuccin.palettes").get_palette("mocha")

  local navic = require("nvim-navic")

  local mode_map = {
    ["n"] = "",
    ["no"] = "O-PENDING",
    ["nov"] = "O-PENDING",
    ["noV"] = "O-PENDING",
    ["no"] = "O-PENDING",
    ["niI"] = " ",
    ["niR"] = " ",
    ["niV"] = " ",
    ["nt"] = " ",
    ["v"] = "VISUAL",
    ["vs"] = "VISUAL",
    ["V"] = "V-LINE",
    ["Vs"] = "V-LINE",
    [""] = "V-BLOCK",
    ["s"] = "V-BLOCK",
    ["s"] = "SELECT",
    ["S"] = "S-LINE",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["ix"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rc"] = "REPLACE",
    ["Rx"] = "REPLACE",
    ["Rv"] = "V-REPLACE",
    ["Rvc"] = "V-REPLACE",
    ["Rvx"] = "V-REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "EX",
    ["ce"] = "EX",
    ["r"] = "REPLACE",
    ["rm"] = "MORE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
  }

  require("lualine").setup({
    options = {
      icons_enabled = true,
      -- theme = "auto",
      theme = "catppuccin",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      -- section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      always_divide_middle = false,
      globalstatus = true,
      refresh = {
        statusline = 300,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = {
        {
          -- "mode",
          function()
            return mode_map[vim.api.nvim_get_mode().mode] or "__"
          end,
          separator = {
            -- left = nil,
            -- right = nil,
            left = ui.common.SeparatorLStart,
            right = ui.common.SeparatorREnd,
            -- left = icons.ui.SeparatorLStart,
            -- right = icons.ui.SeparatorLEndAngle,
            -- right = icons.ui.SeparatorSquare,
          },
          -- color = { fg = nil, bg = nil, gui = "bold" },
          padding = { left = 1, right = 1 },
          color = { fg = cp.base, bg = cp.lavender },
        },
      },
      lualine_b = {
        {
          "branch",
          icon = ui.git.Branch,
          separator = {
            right = ui.common.AngleRight,
            -- left = ui.common.SeparatorLStart,
            -- right = ui.common.SeparatorREnd,
          },
          -- color = { fg = nil, bg = c.bg_highlight, gui = nil },
          padding = { left = 2, right = 1 },
          color = { fg = cp.base, bg = cp.overlay1, gui = "bold" },
        },
        {
          -- "diff",
          -- colored = true,
          -- -- diff_color = {
          -- --   added = { fg = cp.green, bg = nil }, -- Changes diagnostic's info color
          -- --   modified = { fg = cp.blue, bg = nil }, -- changes diagnostic's warn color
          -- --   removed = { fg = c.red, bg = nil }, -- changes diagnostic's error color
          -- -- },
          -- separator = {
          --   -- right = ui.common.SeparatorSquare,
          --   -- right = ui.common.SeparatorREnd,
          -- },
          -- color = { fg = nil, bg = cp.surface0, gui = nil },
          -- -- color = { fg = nil, bg = c.bg_highlight, gui = nil },
          -- padding = 1,
        },
        {
          "diagnostics",
          -- table of diagnostic sources, available sources:
          -- 'nvim_lsp', 'nvim', 'coc', 'ale', 'vim_lsp'
          -- Or a function that returns a table like
          --   {error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt}
          sources = { "nvim_diagnostic" },
          -- displays diagnostics from defined severity
          sections = { "error", "warn", "info", "hint" },
          symbols = {
            error = ui.diagnostics.Error,
            warning = ui.diagnostics.Warning,
            info = ui.diagnostics.Information,
            hint = ui.diagnostics.Hint,
          },
          colored = true, -- displays diagnostics status in color if set to true
          update_in_insert = false, -- Update diagnostics in insert mode
          always_visible = false, -- Show diagnostics always
          separator = {
            -- left = ui.common.SeparatorLStart,
            -- right = ui.common.SeparatorREnd,
          },
          color = { fg = nil, bg = cp.base, gui = nil },
          -- color = { fg = nil, bg = c.bg_highlight, gui = nil },
          padding = { left = 1, right = 1 },
        },
      },
      lualine_c = {
        {
          "filename",
          path = 1,
          -- padding = { left = 100, right = 90 },
          padding = 2,
          color = { fg = cp.subtext1, bg = cp.base },
          -- color = { fg = c.fg_dark, bg = nil },
        },
      },
      -- lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_x = { "filetype" },
      lualine_y = {},
      lualine_z = {
        {
          "location",
          separator = {
            -- left = nil,
            -- right = nil,
            left = ui.common.SeparatorLStart,
            -- right = ui.common.SeparatorREnd,
          },
          padding = { left = 0, right = 1 },
        },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "filetype" },
      lualine_z = {},
    },
    winbar = {
      lualine_a = {
        {
          "filename",
          color = "WinBarFilenameActive",
        },
      },
      lualine_b = {
        --   {
        --     function()
        --       return navic.get_location()
        --     end,
        --     cond = function()
        --       return navic.is_available()
        --     end,
        --     color = "WinBar",
        --   },
      },
    },
    inactive_winbar = {
      lualine_a = {
        {
          "filename",
          color = "WinBarFilenameInactive",
        },
      },
      lualine_b = {
        --   {
        --     function()
        --       return navic.get_location()
        --     end,
        --     cond = function()
        --       return navic.is_available()
        --     end,
        --     color = "WinBarInactive",
        --   },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    extensions = {},
  })
end

return M
