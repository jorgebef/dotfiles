-- NEOFORMAT options and remaps
local remap = vim.api.nvim_set_keymap
local nsn_opts = { noremap = true, silent = true, nowait = true }

vim.g.neoformat_basic_format_trim = 1

remap('n', '<leader>F', ':Neoformat<CR>', nsn_opts)
