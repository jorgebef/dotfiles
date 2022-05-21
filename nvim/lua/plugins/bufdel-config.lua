require("bufdel").setup({
	next = "alternate", -- or 'alternate'
	quit = false,
})

local remap = vim.api.nvim_set_keymap
local n_opts = { noremap = true, nowait = true }

remap("n", "<leader>bd", ":BufDel<cr>", n_opts)
