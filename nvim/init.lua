-- ======================== REQUIRE EXTRA FILES ===================
require("options")
require("keymaps")
-- require("winbar")
require("plugins")
-- require("utils.winbar_new")
-- " ====================== AUTOCMD ========================

-- ==============================================
-- ========= TURN ALL JSON INTO JSONC ===========
-- ==============================================
vim.api.nvim_create_augroup("jsoncComments", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "json",
	command = "set filetype=jsonc",
	group = "jsoncComments",
})

-- vim.api.nvim_create_augroup("jsoncComments", { clear = true })
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
-- 	pattern = "*config.json",
-- 	command = "set filetype=jsonc",
-- 	group = "jsoncComments",
-- })

vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = "*",
	command = 'lua vim.highlight.on_yank { higroup="IncSearch", timeout=250 }',
	group = "highlight_yank",
})

vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd(
	{ "VimEnter", "WinEnter", "BufRead", "BufWinEnter" },
	{ pattern = "*[^{T}]", command = 'setlocal cursorline | :echo""', group = "CursorLine" }
)
vim.api.nvim_create_autocmd({ "WinLeave" }, { pattern = "*", command = "setlocal nocursorline", group = "CursorLine" })

vim.api.nvim_create_autocmd({
	"CursorMoved",
	"BufWinEnter",
	"BufFilePost",
	"InsertEnter",
	"BufWritePost",
}, {
	callback = function()
		require("utils.winbar").get_winbar(false)
	end,
})

vim.api.nvim_create_autocmd({
	"BufLeave",
}, {
	callback = function()
		require("utils.winbar").get_winbar(true)
	end,
})

-- " ====================== / AUTOCMD ========================

-- ========================================================
-- set colorscheme
vim.g.catppuccin_flavour = "macchiato"
vim.api.nvim_exec([[colorscheme catppuccin]], false)
-- ========================================================

-- ========================================================
-- set custom highlights
require("highlights")
-- ========================================================
