require("bufdel").setup({
	next = "alternate", -- or 'alternate'
	quit = false,
})

vim.keymap.set("n", "<leader>bd", ":BufDel<cr>", { silent = true, nowait = true })
