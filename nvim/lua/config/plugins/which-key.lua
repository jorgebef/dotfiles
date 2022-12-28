local M = { "folke/which-key.nvim" }

function M.config()
  local wk = require("which-key")

  -- make sure to run this code before calling setup()
  -- refer to the full lists at https://github.com/folke/which-key.nvim/blob/main/lua/which-key/plugins/presets/init.lua
  local presets = require("which-key.plugins.presets")
  presets.operators["v"] = nil

  wk.setup({
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      ["<space>"] = "SPC",
      ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  })

  wk.register({
    ["+"] = "   Enlarge buffer",
    ["-"] = "   Reduce buffer",
    ["="] = " 﩯 Balance splits",
    ["3"] = "   highlight word",
    b = {
      name = " 裡 Buffer",
      d = "   Delete",
    },
    c = {
      name = "   Config",
      R = " 勒 Reload",
    },
    C = {
      name = "   Colorizer",
    },
    e = " פּ  File Explorer",
    f = {
      name = "   Telescope", -- optional group name
      b = { "Find Buffers" }, -- create a binding with label
      f = { "   Find File" }, -- create a binding with label
      F = { "Find project files" }, -- create a binding with label
      g = { "Live Grep" }, -- create a binding with label
      G = { "Find git files" }, -- create a binding with label
      r = { "Resume" }, -- create a binding with label
      s = { "Find LSP document symbols" }, -- create a binding with label
      S = { "Find LSP project symbols" }, -- create a binding with label
    },
    g = {
      name = "   GitSigns", -- optional group name
      b = { "   Blame" }, -- create a binding with label
      n = { "   Next" }, -- create a binding with label
      p = { "   Previous" }, -- create a binding with label
      P = { " 繁  Preview" }, -- create a binding with label
      r = { " 碑 reset hunk" },
      R = { "   Reset buffer" },
      s = { "   stage hunk" },
      S = { "   Stage buffer" },
    },
    l = {
      name = " 力 LSP",
      a = { "Code Action" },
      d = { "Go to definition" },
      D = { "Go to Type Definition" },
      f = { "Format" },
      n = { "Jump to next Diagnostic" },
      N = { "Jump to next ERROR" },
      p = { "Jump to previous Diagnostic" },
      P = { "Jump to previous ERROR" },
      r = { "Rename Variable" },
      R = { "Go to reference" },
    },
    o = "   Add one line below",
    O = "   Add one line above",
    q = "   Quit!!",
    S = "   Search and replace",
    V = " 溺 Vertical split!!",
    w = "   Write",
    y = "   Copy to clipboard",
  }, { prefix = "<leader>" })
end

return M
