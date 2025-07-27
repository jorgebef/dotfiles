local M = {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  dependencies = {
    { "SmiteshP/nvim-navic" },
    -- { "nvim-tree/nvim-web-devicons" },
    -- { "folke/noice.nvim" },
  },
}

function M.config()
  ---@type UISymbols
  local ui = require("config.ui")

  -- local noice = require("noice")

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
    ["c"] = "",
    ["cv"] = "EX",
    ["ce"] = "EX",
    ["r"] = "REPLACE",
    ["rm"] = "MORE",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
  }

  -- local palette = require("catppuccin.palettes").get_palette()
  -- local palette = require("kanso.colors").setup().palette
  -- local colors = require("kanagawa.colors").setup()
  local colors = require("kanagawa.colors").setup()
  local palette = colors.theme

  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "auto",
      -- theme = "catppuccin",
      -- theme = "kanagawa",
      component_separators = "",
      section_separators = "",
      -- section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      always_divide_middle = false,
      globalstatus = true,
      refresh = {
        statusline = 100,
        winbar = 100,
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
            left = ui.icons.common.SeparatorLStart,
            right = ui.icons.common.SeparatorREnd,
          },
          -- color = { fg = nil, bg = nil, gui = "bold" },
          padding = { left = 1, right = 1 },
          -- color = { fg = cp.base, bg = cp.lavender },
        },
      },
      lualine_b = {
        {
          "branch",
          icon = ui.icons.git.Branch,
          padding = { left = 2, right = 1 },
          -- color = { fg = cp.base, bg = cp.overlay1, gui = "bold" },
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
            error = ui.icons.diagnostics.Error,
            warning = ui.icons.diagnostics.Warning,
            info = ui.icons.diagnostics.Information,
            hint = ui.icons.diagnostics.Hint,
          },
          colored = true, -- displays diagnostics status in color if set to true
          update_in_insert = false, -- Update diagnostics in insert mode
          always_visible = false, -- Show diagnostics always
          padding = { left = 1, right = 1 },
        },
      },
      lualine_c = {
        {
          "filename",
          path = 3,
          -- padding = { left = 100, right = 90 },
          padding = 2,
          -- color = { fg = cp.subtext1, bg = cp.base },
          -- color = { fg = c.fg_dark, bg = nil },
          color = { fg = palette.ui.nontext },
        },
      },
      lualine_x = {
        {
          function()
            if vim.fn.reg_recording() ~= "" then
              return "󰻃  macro ( " .. vim.fn.reg_recording() .. " )"
            else
              -- return noice.api.status.message.get() or ""
              return ""
            end
          end,
          color = function()
            return { fg = vim.fn.reg_recording() ~= "" and palette.diag.error or palette.diag.error }
          end,
        },
        -- {
        --   noice.api.status.command.get,
        --   cond = noice.api.status.command.has,
        --   color = { fg = palette.blue },
        -- },
        -- {
        --   noice.api.status.mode.get,
        --   cond = noice.api.status.mode.has,
        --   color = { fg = "#ff9e64" },
        -- },

        {
          function()
            local starts = vim.fn.line("v")
            local ends = vim.fn.line(".")
            local count = starts <= ends and ends - starts + 1 or starts - ends + 1
            local wc = vim.fn.wordcount()
            return count .. " lines - " .. wc["visual_chars"] .. " chars"
          end,
          cond = function()
            return vim.fn.mode():find("[Vv]") ~= nil
          end,
          color = { fg = palette.ui.fg_dim },
        },
      },
      lualine_y = {
        { "filetype" },
      },
      lualine_z = {
        {
          "location",
          separator = {
            -- left = nil,
            -- right = nil,
            left = ui.icons.common.SeparatorLStart,
          },
          padding = { left = 0, right = 1 },
        },
      },
    },
    winbar = {
      lualine_a = {
        {
          "filename",
          -- returns the parent folder and filename only
          path = 4,
          fmt = function(name)
            -- match the substring until the first `/` symbol
            local folder = name:match("(.+)/") or ""
            if folder == "" then
              return nil
            else
              return ui.icons.kind.Folder .. folder .. " " .. "-> "
            end
          end,
          padding = { left = 1, right = 0 },
          -- color = { fg = palette.text, bg = "NONE" },
          color = "WinBar",
        },
        {
          "filetype",
          colored = true, -- Displays filetype icon in color if set to true
          icon_only = true, -- Display only an icon for filetype
          padding = 0,
          color = { bg = "NONE" },
        },
        {
          "filename",
          padding = { left = 0, right = 3 },
          color = "WinBar",
        },
      },
      lualine_b = { "navic" },
    },
    inactive_winbar = {
      lualine_a = {
        {
          "filename",
          -- returns the parent folder and filename only
          path = 4,
          fmt = function(name)
            -- match the substring until the first `/` symbol
            local folder = name:match("(.+)/") or ""
            if folder == "" then
              return nil
            else
              return ui.icons.kind.Folder .. folder .. " " .. "-> "
            end
          end,
          padding = { left = 1, right = 0 },
          color = "WinBarNC",
        },
        {
          "filetype",
          colored = false, -- Displays filetype icon in color if set to true
          icon_only = true, -- Display only an icon for filetype
          padding = 0,
          -- color = "WinbarInactive",
          color = "WinbarNC",
        },
        {
          "filename",
          padding = { left = 0, right = 3 },
          -- color = "WinbarInactive",
          color = "WinbarNC",
        },
      },
      lualine_b = {},
      lualine_c = {},
    },
    extensions = {},
  })
end

return M
