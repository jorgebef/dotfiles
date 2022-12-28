local M = { "lukas-reineke/indent-blankline.nvim" }

function M.config()
	-- vim.opt.list = true
	-- vim.opt.listchars:append("space:⋅")
	-- vim.opt.listchars:append("eol:↴")

	-- vim.g.indent_blankline_context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments', 'return'}

	vim.g.indent_blankline_context_patterns = {
		"declaration",
		"expression",
		"pattern",
		"primary_expression",
		"statement",
		"switch_body",
		"function",
		"jsx_attribute",
		"jsx_closing_element",
		"jsx_element",
		"jsx_expression",
		"jsx_fragment",
		"jsx_namespace_name",
		"jsx_opening_element",
		"jsx_self_closing_element",
	}

	require("indent_blankline").setup({
		-- char = "|",
		buftype_exclude = {
			"terminal",
		},
		filetype_exclude = {
			"startify",
			"dashboard",
			"help",
			"NvimTree",
			"lspsagafinder",
			"packer",
			"mason",
			"lazy",
		},
		-- space_char_blankline = " ",
		show_current_context = true,
		-- show_current_context = false,
		-- show_current_context_start = true,
	})
end

return M
