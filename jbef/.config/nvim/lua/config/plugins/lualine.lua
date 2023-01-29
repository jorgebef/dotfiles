local M = { "nvim-lualine/lualine.nvim" }

function M.config()
  local ui = require("config.ui")
  local cp = require("catppuccin.palettes").get_palette("mocha")

  local navic = require("nvim-navic")

  local function custom_mode()
    return [[ ]]
  end

  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "auto",
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
        statusline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = {
        {
          -- "mode",
          custom_mode,
          separator = {
            left = nil,
            right = nil,
            -- left = icons.ui.SeparatorLStart,
            -- right = icons.ui.SeparatorLEndAngle,
            -- right = icons.ui.SeparatorSquare,
          },
          padding = { left = 0, right = 0 },
        },
      },
      lualine_b = {
        {
          "branch",
          separator = {
            -- right = icons.ui.SeparatorLEndAngle,
            right = ui.common.SeparatorSquare,
          },
          color = { fg = nil, bg = cp.surface0, gui = nil },
          padding = { left = 2, right = 1 },
        },
        {
          "diff",
          colored = true,
          -- diff_color = {
          -- 	added = { fg = cp.green, bg = nil }, -- Changes diagnostic's info color
          -- 	modified = { fg = cp.yellow, bg = nil }, -- changes diagnostic's warn color
          -- 	removed = { fg = cp.red, bg = nil }, -- changes diagnostic's error color
          -- },
          separator = {
            right = ui.common.SeparatorSquare,
          },
          color = { fg = nil, bg = cp.surface0, gui = nil },
          padding = 1,
        },
      },
      lualine_c = {
        {
          "filename",
          path = 1,
          padding = { left = 4, right = 2 },
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
          -- symbols = { error = " ", warn = " ", info = " " },
          symbols = {
            error = ui.diagnostics.Error,
            warning = ui.diagnostics.Warning,
            info = ui.diagnostics.Information,
            hint = ui.diagnostics.Hint,
          },
          colored = true, -- displays diagnostics status in color if set to true
          update_in_insert = false, -- Update diagnostics in insert mode
          always_visible = false, -- Show diagnostics always
          -- separator = {
          -- 	right = icons.ui.SeparatorSquare,
          -- },
          padding = { left = 2, right = 2 },
        },
      },
      -- lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_x = { "filetype" },
      lualine_y = {
        {
          "progress",
          -- "require'lsp-status'.status()",
          -- separator = {
          -- 	left = icons.ui.SeparatorSquare,
          -- },
          color = { fg = nil, bg = cp.surface0, gui = nil },
          padding = { left = 1, right = 1 },
        },
      },
      -- lualine_y = {'%{ObsessionStatus(" "," ")}'},
      lualine_z = {
        {
          "location",
          separator = {
            left = nil,
            right = nil,
            -- 	left = icons.ui.SeparatorRStartAngleAngle,
            -- 	right = icons.ui.SeparatorSquare,
          },
          padding = { left = 1, right = 1 },
        },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "filetype" },
      -- lualine_y = {'%{ObsessionStatus(" "," ")}'},
      lualine_z = {},
    },
    winbar = {
      lualine_a = {
        {
          "filename",
          color = "WinBarFilenameActive",
          separator = {
            left = ui.common.SeparatorLStart,
            -- right = icons.ui.SeparatorLEndAngle,
            right = ui.common.SeparatorSquare,
          },
          -- separator = { left = "█", right = "" },
          left_padding = 1,
          right_padding = 1,
        },
      },
      lualine_b = {
        {
          navic.get_location,
          cond = navic.is_available,
          color = "WinBar",
        },
      },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    inactive_winbar = {
      lualine_a = {
        {
          "filename",
          color = "WinBarFilenameInactive",
        },
      },
      lualine_b = {
        {
          navic.get_location,
          cond = navic.is_available,
          color = "WinBarInactive",
        },
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
