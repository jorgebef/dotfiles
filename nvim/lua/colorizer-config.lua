	require("colorizer").setup()

local remap = vim.api.nvim_set_keymap
local nsn_opts = { noremap = true, silent = true, nowait = true }
remap("n", "<leader>Ct", ':ColorizerToggle<cr>', nsn_opts)
