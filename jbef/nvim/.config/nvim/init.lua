-- ordinary Neovim
require("config.options") -- load options last
require("core.lazy") -- load Lazy (plugin manager)
require("core.lsp") -- load lsp config file
require("config.keymaps") -- leader key must be set before lazy is loaded
require("config.autocommands") -- load autocommands
require("config.user_commands") -- load user commands

-- Load all LSP's in "lua/config/lsp"
local lsp_path = vim.fn.stdpath("config") .. "/lua/config/lsp"
-- local lsp_path = vim.fn.stdpath("config") .. "/lsp"

-- Then load all other LSP configs
for _, file in ipairs(vim.fn.readdir(lsp_path)) do
  if file:match("%.lua$") then
    local module_name = "config.lsp." .. file:gsub("%.lua$", "")
    require(module_name)
  end
end
