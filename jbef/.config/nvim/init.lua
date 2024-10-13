if vim.g.vscode then
  -- VSCode extension
else
  -- ordinary Neovim
  require("config.keymaps") -- leader key must be set before lazy is loaded
  require("config.autocommands") -- load autocommands
  require("config.user_commands") -- load user commands
  require("config.options") -- load options last
  require("config.lazy") -- load Lazy (plugin manager)
end
