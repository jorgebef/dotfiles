-- Utilities for creating configurations
-- local util = require("formatter.util")

local prettier = require("formatter.filetypes.typescriptreact").prettier
local stylua = require("formatter.filetypes.lua").stylua

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = false,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype go here
		-- and will be executed in order
		lua = {
			stylua,
		},
		json = {
			prettier,
		},
		javascript = {
			prettier,
		},
		typescript = {
			prettier,
		},
		javascriptreact = {
			prettier,
		},
		typescriptreact = {
			prettier,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		-- ["*"] = {
		--   -- "formatter.filetypes.any" defines default configurations for any
		--   -- filetype
		--   require("formatter.filetypes.any").remove_trailing_whitespace
		-- }
	},
})

local map = vim.api.nvim_set_keymap
local ns_opts = { noremap = true, silent = true }
map("n", "<leader>lf", ":Format<CR>", ns_opts)
