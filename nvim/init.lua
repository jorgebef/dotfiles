-- ======================== REQUIRE EXTRA FILES ===================
require("options")
require("keymaps")
require("plugins")
-- require("gui-options")

-- ==============================================
-- ========= TURN ALL JSON INTO JSONC ===========
-- ==============================================
vim.api.nvim_create_augroup("jsoncComments", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "json",
	command = "set filetype=jsonc",
	group = "jsoncComments",
})

--[[ local envGroup = vim.api.nvim_create_augroup("__env", { clear = true }) ]]
--[[ vim.api.nvim_create_autocmd("BufEnter", { ]]
--[[ 	pattern = ".env*", ]]
--[[ 	group = envGroup, ]]
--[[ 	callback = function(args) ]]
--[[ 		vim.diagnostic.disable(args.buf) ]]
--[[ 	end, ]]
--[[ }) ]]

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

-- " ====================== / AUTOCMD ========================

-- ========================================================
vim.cmd([[colorscheme catppuccin]])

require("highlights")
-- ========================================================
