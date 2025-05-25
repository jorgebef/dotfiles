-- ordinary Neovim
require("config.keymaps") -- leader key must be set before lazy is loaded
require("config.autocommands") -- load autocommands
require("config.user_commands") -- load user commands
require("config.options") -- load options last
require("config.lazy") -- load Lazy (plugin manager)

-- Load all LSP's in "lua/config/lsp"
local lsp_path = vim.fn.stdpath("config") .. "/lua/config/lsp"

-- First, explicitly load the global configuration
require("config.lsp.global")

-- Then load all other LSP configs
for _, file in ipairs(vim.fn.readdir(lsp_path)) do
  if file:match("%.lua$") and file ~= "global.lua" then
    local module_name = "config.lsp." .. file:gsub("%.lua$", "")
    require(module_name)
  end
end
