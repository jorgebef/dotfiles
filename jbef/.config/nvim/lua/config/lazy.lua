-- The package manager by Folke
-- https://github.com/folke/lazy.nvim

-- !WARNING vvvvvvvvvv
-- LEADERKEY MUST BE SET BEFORE THIS FILE IS LOADED

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
else
  vim.opt.runtimepath:prepend(lazypath)
end

local lazy_plugin_manager = require("lazy")
local ui = require("config.ui")

require("util.lazy-nvim-util").setup()

-- Structure is as follows:
-- ✅ init.lua where I require config.lazy
-- ✅ config.lazy where I bootstrap and setup lazy.nvim
-- ✅ config.plugins is my main plugin config module
-- ✅ Any submodule of config.plugins (submodules) will be automatically loaded as well.

-- For further clarification, check docs:
-- https://github.com/folke/lazy.nvim#-structuring-your-plugins:~:text=%F0%9F%93%82,Structuring%20Your%20Plugins

lazy_plugin_manager.setup("config.plugins", {
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
  },
  install = { colorscheme = { "catppuccin" } },
  -- install = { colorscheme = { "tokyonight" } },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.8, height = 0.8 },
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = ui.border.Block,
  },
})

vim.keymap.set("n", "<leader>L", ":Lazy<CR>", { noremap = true })

vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("tokyonight")
