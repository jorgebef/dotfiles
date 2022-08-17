-- ======================== REQUIRE EXTRA FILES ===================
require("options")
require("keymaps")
-- local winbar = require("utils.winbar_new")
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

-- vim.api.nvim_create_autocmd({
-- 	"CursorMoved",
-- 	"BufWinEnter",
-- 	"BufEnter",
-- 	"BufLeave",
-- 	"CursorHold",
-- 	"BufFilePost",
-- 	"InsertEnter",
-- 	"BufWritePost",
-- }, {
-- 	callback = function()
-- 		winbar.get_winbar()
-- 	end,
-- })

-- vim.api.nvim_create_autocmd({
-- 	"BufLeave",
-- }, {
-- 	callback = function()
-- 		winbar.get_winbar(true)
-- 	end,
-- })

-- " ====================== / AUTOCMD ========================

-- ========================================================
vim.g.catppuccin_flavour = "macchiato"
vim.cmd([[colorscheme catppuccin]])

require("highlights")
-- ========================================================
