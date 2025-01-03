-- !WARNING vvvvvvvvvv
-- LEADERKEY MUST BE SET BEFORE THIS FILE IS LOADED

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")
---@type UISymbols
local ui = require("config.ui")

-- require("util.lazy-nvim-util").setup()

-- Structure is as follows:
-- ✅ init.lua where I require config.lazy
-- ✅ config.lazy where I bootstrap and setup lazy.nvim
-- ✅ config.plugins is my main plugin config module
-- ✅ Any submodule of config.plugins (submodules) will be automatically loaded as well.

-- For further clarification, check docs:
-- https://github.com/folke/lazy.nvim#-structuring-your-plugins:~:text=%F0%9F%93%82,Structuring%20Your%20Plugins

lazy.setup("plugins", {
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
  install = {
    colorscheme = {
      -- "catppuccin",
      -- "flexoki",
      -- "rose-pine",
    },
  },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = ui.border.Block,
  },
  dev = {
    -- Directory where you store your local plugin projects. If a function is used,
    -- the plugin directory (e.g. `~/projects/plugin-name`) must be returned.
    ---@type string | fun(plugin: LazyPlugin): string
    path = "~/Developer/Side-Projects/",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = { "jorgebef" }, -- For example {"folke"}
    fallback = true, -- Fallback to git when local plugin doesn't exist
  },
})

vim.keymap.set("n", "<leader>L", ":Lazy<CR>", { noremap = true })

-- vim.cmd([[colorscheme catppuccin-mocha]])
-- vim.cmd([[colorscheme nordic]])
-- vim.cmd([[colorscheme kanagawa]])
vim.cmd([[colorscheme kanagawa-groove]])
-- vim.cmd([[colorscheme rose-pine]])
-- vim.cmd([[colorscheme tokyonight]])
