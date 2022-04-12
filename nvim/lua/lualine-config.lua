local cp = {
	rosewater = "#F5DFDA", -- Rosewater
	flamingo = "#F2CBCB", -- Flamingo			-- done
	mauve = "#C6A4F8", -- Mauve					-- done
	pink = "#F5BFE7", -- Pink					-- done
	red = "#F586A2", -- Red						-- done
	maroon = "#EB9DA4", -- Maroon				-- done
	peach = "#FCB081", -- Peach					-- done
	yellow = "#F8DEA9", -- Yellow				-- done
	green = "#A9E4A3", -- Green					-- done
	blue = "#8CB3FA", -- Blue					-- done
	sky = "#89DCFD", -- Sky						-- done
	teal = "#88DFD2", -- Teal					-- done
	lavender = "#C7CBFD", -- Lavender			-- done
	white = "#D2DAF1", -- White					-- done
	gray2 = "#B9C0DB", -- Gray2
	gray1 = "#6F7599", -- Gray1
	gray0 = "#5E6487", -- Gray0
	black4 = "#3E435E", -- Black4
	black3 = "#2B3045", -- Black3
	black2 = "#24273A", -- Black2				-- done
	black1 = "#1F2233", -- Black1
	black0 = "#1A1B26", -- Black0
}



require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		-- theme = 'sonokai',
		-- section_separators = { left = '█', right = '█'},
		-- section_separators = { left = '', right = ''},
		-- component_separators = { left = '|', right = '|'},
		-- component_separators = { left = '', right = ''},
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		-- section_separators = { left = '', right = ''},
		disabled_filetypes = {},
		always_divide_middle = false,
    globalstatus = true
	},
	sections = {
		lualine_a = {
			{
				"mode",
				separator = { left = "", right = "" },
				left_padding = 1,
				right_padding = 1,
			},
		},
		lualine_b = {
			{
				"branch",
				separator = { right = "" },
				left_padding = 2,
			},
			{
				"diff",
				colored = true,
				diff_color = {
					added = { fg=cp.green, bg = nil }, -- Changes diagnostic's info color
					modified = { fg=cp.yellow, bg = nil }, -- changes diagnostic's warn color
					removed = { fg=cp.red,bg=nil }, -- changes diagnostic's error color
				},
				separator = { right = "" },
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
				-- all colors are in format #rrggbb
				diagnostics_color = {
					error = { fg=cp.red,bg=nil }, -- changes diagnostic's error color
					warn = { fg=cp.yellow, bg = nil }, -- changes diagnostic's warn color
					info = { fg=cp.blue, bg = nil }, -- Changes diagnostic's info color
					hint = { fg=cp.rosewater, bg = nil }, -- Changes diagnostic's hint color
				},
				-- symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'}
				symbols = { error = " ", warn = " ", info = " " },
				colored = true, -- displays diagnostics status in color if set to true
				update_in_insert = false, -- Update diagnostics in insert mode
				always_visible = false, -- Show diagnostics always
				separator = { right = "" },
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
				separator = { left = "" },
				right_padding = 1,
			},
		},
		-- lualine_y = {'%{ObsessionStatus(" "," ")}'},
		lualine_z = {
			{
				"location",
				separator = { left = "", right = "" },
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
