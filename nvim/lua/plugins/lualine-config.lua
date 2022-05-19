-- local cp = {
-- 	rosewater = "#F5DFDA",
-- 	flamingo = "#F2CBCB",
-- 	pink = "#F5BFE7",
-- 	mauve = "#C59FF6",
-- 	red = "#F67E98",
-- 	maroon = "#F1949B",
-- 	peach = "#FEA571",
-- 	yellow = "#F1D8A4",
-- 	green = "#A1DF8E",
-- 	teal = "#85E0D1",
-- 	sky = "#89DCFD",
-- 	blue = "#83ABF9",
-- 	sapphire = "#34C3DC",
-- 	lavender = "#B8C1FE",
-- 	white = "#C5CFF5",
-- 	gray2 = "#AEB7DA",
-- 	gray1 = "#979FC0",
-- 	gray0 = "#8087A5",
-- 	black5 = "#696F8A",
-- 	black4 = "#52576F",
-- 	black3 = "#3B3F55",
-- 	black2 = "#24273A",
-- 	black1 = "#1F2232",
-- 	black0 = "#181926",
-- }

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
		globalstatus = true,
	},
	sections = {
		lualine_a = {
			{
				"mode",
				-- separator = { left = "", right = "" },
				-- separator = { left = "█", right = "█" },
				separator = { left = "█", right = "" },
				left_padding = 1,
				right_padding = 1,
			},
		},
		lualine_b = {
			{
				"branch",
				-- separator = { right = "" },
				-- separator = { left = "█", right = "█" },
				separator = { left = "", right = "" },
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
				separator = { left = "", right = "" },
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
				-- diagnostics_color = {
				-- 	error = { fg = cp.red, bg = nil }, -- changes diagnostic's error color
				-- 	warn = { fg = cp.yellow, bg = nil }, -- changes diagnostic's warn color
				-- 	info = { fg = cp.blue, bg = nil }, -- Changes diagnostic's info color
				-- 	hint = { fg = cp.saphire , bg = nil }, -- Changes diagnostic's hint color
				-- },
				-- symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'}
				symbols = { error = " ", warn = " ", info = " " },
				colored = true, -- displays diagnostics status in color if set to true
				update_in_insert = false, -- Update diagnostics in insert mode
				always_visible = false, -- Show diagnostics always
				-- separator = { right = "" },
				-- separator = { left = "█", right = "█" },
				separator = { left = "", right = "" },
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
				-- separator = { left = "" },
				-- separator = { left = "█", right = "█" },
				separator = { left = "", right = "" },
				right_padding = 1,
			},
		},
		-- lualine_y = {'%{ObsessionStatus(" "," ")}'},
		lualine_z = {
			{
				"location",
				-- separator = { left = "", right = "" },
				-- separator = { left = "█", right = "█" },
				separator = { left = "", right = "█" },
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
