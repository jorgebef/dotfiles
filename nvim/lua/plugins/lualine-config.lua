local icons = require("icons")

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		-- section_separators = { left = '', right = ''},
		disabled_filetypes = {},
		always_divide_middle = false,
		globalstatus = true,
	},
	sections = {
		lualine_a = {
			{
				"mode",
				separator = {
					left = icons.ui.SeparatorLStart,
					right = icons.ui.SeparatorLEnd,
				},
				-- separator = { left = "█", right = "" },
				left_padding = 1,
				right_padding = 1,
			},
		},
		lualine_b = {
			{
				"branch",
				-- separator = { right = "" },
				-- separator = { left = "", right = "" },
				separator = {
					-- right = ""
					right = icons.ui.SeparatorLEnd,
				},
				left_padding = 2,
			},
			{
				"diff",
				colored = true,
				-- diff_color = {
				-- 	added = { fg = cp.green, bg = nil }, -- Changes diagnostic's info color
				-- 	modified = { fg = cp.yellow, bg = nil }, -- changes diagnostic's warn color
				-- 	removed = { fg = cp.red, bg = nil }, -- changes diagnostic's error color
				-- },
				-- separator = { right = "" },
				-- separator = { left = "█", right = "█" },
				-- separator = { left = "", right = "" },
				separator = {
					-- right = ""
					right = icons.ui.SeparatorLEnd,
				},
				left_padding = 1,
			},
			{
				"diagnostics",
				-- table of diagnostic sources, available sources:
				-- 'nvim_lsp', 'nvim', 'coc', 'ale', 'vim_lsp'
				-- Or a function that returns a table like
				--   {error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt}
				sources = { "nvim_diagnostic", "coc" },
				-- displays diagnostics from defined severity
				sections = { "error", "warn", "info", "hint" },
				-- symbols = { error = " ", warn = " ", info = " " },
				symbols = {
					error = icons.diagnostics.Error,
					warning = icons.diagnostics.Warning,
					info = icons.diagnostics.Information,
					hint = icons.diagnostics.Hint,
				},
				colored = true, -- displays diagnostics status in color if set to true
				update_in_insert = false, -- Update diagnostics in insert mode
				always_visible = false, -- Show diagnostics always
				-- separator = { right = "" },
				-- separator = { left = "", right = "" },
				separator = {
					-- right = ""
					right = icons.ui.SeparatorLEnd,
				},
				left_padding = 1,
			},
		},
		lualine_c = {
			{
				"filename",
				path = 1,
			},
		},
		-- lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_x = { "filetype" },
		lualine_y = {
			{
				"progress",
				"require'lsp-status'.status()",
				-- separator = { left = "" },
				-- separator = { left = "" },
				separator = {
					left = icons.ui.SeparatorRStart,
				},
				-- separator = { left = "", right = "" },
				right_padding = 1,
			},
		},
		-- lualine_y = {'%{ObsessionStatus(" "," ")}'},
		lualine_z = {
			{
				"location",
				-- separator = { left = "", right = "" },
				separator = {
					left = icons.ui.SeparatorRStart,
					right = icons.ui.SeparatorREnd,
				},
				-- separator = { left = "", right = "█" },
				left_padding = 1,
			},
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "filetype" },
		-- lualine_y = {'%{ObsessionStatus(" "," ")}'},
		lualine_z = {},
	},
	tabline = {
		-- lualine_a = {'buffers'},
		-- lualine_b = {'branch'},
		-- lualine_c = {'filename'},
		-- lualine_x = {},
		-- lualine_y = {},
		-- lualine_z = {'tabs'}
	},
	extensions = {},
})
