local M = { "glepnir/lspsaga.nvim", branch = "main" }

function M.config()

local keymap = vim.keymap.set
local saga = require("lspsaga")
local lspsaga_diagnostic = require("lspsaga.diagnostic")

saga.init_lsp_saga({
	-- Options with default value
	-- "single" | "double" | "rounded" | "bold" | "plus"
	border_style = "rounded",
	--the range of 0 for fully opaque window (disabled) to 100 for fully
	--transparent background. Values between 0-30 are typically most useful.
	saga_winblend = 0,
	-- when cursor in saga window you config these to move
	move_in_saga = { prev = "<C-p>", next = "<C-n>" },
	-- Error, Warn, Info, Hint
	-- use emoji like
	-- { "🙀", "😿", "😾", "😺" }
	-- or
	-- { "😡", "😥", "😤", "😐" }
	-- and diagnostic_header can be a function type
	-- must return a string and when diagnostic_header
	-- is function type it will have a param `entry`
	-- entry is a table type has these filed
	-- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
	-- diagnostic_header = { " ", " ", " ", "ﴞ " },
	diagnostic_header = { "🙀", "😿", "😾", "😺" },
	-- preview lines above of lsp_finder
	preview_lines_above = 0,
	-- preview lines of lsp_finder and definition preview
	max_preview_lines = 20,
	-- use emoji lightbulb in default
	code_action_icon = "💡",
	-- if true can press number to execute the codeaction in codeaction window
	code_action_num_shortcut = true,
	-- same as nvim-lightbulb but async
	code_action_lightbulb = {
		enable = true,
		enable_in_insert = true,
		cache_code_action = true,
		sign = false,
		update_time = 150,
		sign_priority = 20,
		virtual_text = true,
	},
	-- finder icons
	finder_icons = {
		def = "  ",
		ref = "諭 ",
		link = "  ",
	},
	-- finder do lsp request timeout
	-- if your project big enough or your server very slow
	-- you may need to increase this value
	finder_request_timeout = 1500,
	finder_action_keys = {
		open = { "o", "<CR>" },
		vsplit = "s",
		split = "i",
		tabe = "t",
		-- quit = { "q", "<ESC>" },
		quit = { "q", "<ESC>", "<leader><ESC>" },
	},
	code_action_keys = {
		-- quit = "q",
		quit = "<leader><ESC>",
		exec = "<CR>",
	},
	definition_action_keys = {
		-- edit = "<C-c>o",
		edit = "<CR>",
		-- vsplit = "<C-c>v",
		vsplit = "<C-v>",
		split = "<C-c>i",
		tabe = "<C-c>t",
		-- quit = "q",
		quit = "<leader><ESC>",
	},
	-- rename_action_quit = "<C-c>",
	rename_action_quit = "<leader><ESC>",
	rename_in_select = true,
	-- show symbols in winbar must nightly
	-- in_custom mean use lspsaga api to get symbols
	-- and set it to your custom winbar or some winbar plugins.
	-- if in_cusomt = true you must set in_enable to false
	symbol_in_winbar = {
		in_custom = false,
		-- DISABLE WINBAR
		enable = false,
		separator = " ",
		show_file = true,
		-- define how to customize filename, eg: %:., %
		-- if not set, use default value `%:t`
		-- more information see `vim.fn.expand` or `expand`
		-- ## only valid after set `show_file = true`
		file_formatter = "",
		click_support = false,
	},
	-- show outline
	show_outline = {
		win_position = "right",
		--set special filetype win that outline window split.like NvimTree neotree
		-- defx, db_ui
		win_with = "",
		win_width = 30,
		auto_enter = true,
		auto_preview = true,
		virt_text = "┃",
		jump_key = "o",
		-- auto refresh when change buffer
		auto_refresh = true,
	},
	-- custom lsp kind
	-- usage { Field = 'color code'} or {Field = {your icon, your color code}}
	custom_kind = {},
	-- if you don't use nvim-lspconfig you must pass your server name and
	-- the related filetypes into this table
	-- like server_filetype_map = { metals = { "sbt", "scala" } }
	server_filetype_map = {},
})

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
-- keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
keymap("n", "<leader>lh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
-- keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
-- keymap({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>", { silent = true })

-- Rename
-- keymap("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", { silent = true })

-- -- Peek Definition
-- -- you can edit the definition file in this flaotwindow
-- -- also support open/vsplit/etc operation check definition_action_keys
-- -- support tagstack C-t jump back
-- keymap("n", "<leader>ld", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- -- Show line diagnostics
-- keymap("n", "<leader>ls", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Diagnostic jump can use `<c-o>` to jump back
-- keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
-- keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- -- Jump to diagnostics
-- keymap("n", "[w", function()
-- 	lspsaga_diagnostic.goto_prev({ severity = { max = "WARN" } })
-- end, { silent = true })
-- keymap("n", "]w", function()
-- 	lspsaga_diagnostic.goto_next({ severity = { max = "WARN" } })
-- end, { silent = true })
-- keymap("n", "[e", function()
-- 	lspsaga_diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
-- end, { silent = true })
-- keymap("n", "]e", function()
-- 	lspsaga_diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
-- end, { silent = true })

-- Outline
-- keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

-- -- Hover Doc
-- keymap("n", "K", function()
-- 	vim.cmd.Lspsaga("hover_doc")
-- end, { silent = true })

-- vim.api.nvim_create_augroup("lspsaga_diagnostics_hold", { clear = true })
-- vim.api.nvim_create_autocmd({ "CursorHold" }, {
--   pattern = "*",
--   command = "Lspsaga show_cursor_diagnostics",
--   group = "lsp_diagnostics_hold",
-- })
end 

return M
