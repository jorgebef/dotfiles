local M = { "mbbill/undotree" }

function M.config()
	vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", {
		silent = true,
		nowait = true,
	})
end

return M
