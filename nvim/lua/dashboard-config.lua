vim.g.dashboard_default_executive='telescope'

local remap = vim.api.nvim_set_keymap
local n_opts = { noremap = true }

remap('n', '<leader>ss', ':SessionSave<CR>', n_opts)
remap('n', '<leader>sl', ':SessionLoad<CR>', n_opts)
