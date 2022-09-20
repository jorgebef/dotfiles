local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local icons = require("icons")

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require("telescope").setup({
	pickers = {
		find_files = {
			hidden = true,
			no_ignore = true,
			find_command = {
				"fd",
				"--color=never",
				"--type",
				"f",
				"--hidden",
				"--follow",
				"--no-ignore",
				"--exclude",
				"node_modules",
				"--exclude",
				".git",
				"--exclude",
				"dist",
				"--exclude",
				"build",
				"--exclude",
				"out",
				"--exclude",
				".next",
				"--exclude",
				".vercel",
				"--exclude",
				".netlify",
			},
		},
	},
	defaults = {
		prompt_prefix = icons.ui.Telescope .. " " .. icons.misc.Carat,
		selection_caret = icons.ui.Arrow,
		-- ====================================================
		-- IT IS VERY SLOW TO RELY ON FILE IGNORE PATTERNS
		-- ====================================================
		file_ignore_patterns = {
			"node_modules/",
			".git/",
			".next/",
			-- "package-lock.json",
			-- 'DS_'
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--ignore-file",
			-- "package-lock.json",
			-- '.gitignore'
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		["zf-native"] = {
			-- options for sorting file-like items
			file = {
				-- override default telescope file sorter
				enable = true,

				-- highlight matching text in results
				highlight_results = true,

				-- enable zf filename match priority
				match_filename = true,
			},
			-- options for sorting all other items
			generic = {
				-- override default telescope generic item sorter
				enable = true,

				-- highlight matching text in results
				highlight_results = true,

				-- disable zf filename match priority
				match_filename = false,
			},
		},

		project = {},
	},
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")

-- Load zf extension, which favors filename over rest of the path
require("telescope").load_extension("zf-native")

-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension("file_browser")

-- =======================================================================
-- ============================== REMAPS =================================
-- =======================================================================

local remap = vim.api.nvim_set_keymap
local nsn_opts = { noremap = true, silent = true, nowait = true }
-- remap("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files({sort_lastused=true})<cr>', nsn_opts)
remap("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<cr>', nsn_opts)
remap("n", "<leader>fF", '<cmd>lua require("telescope-functions").project_files()<cr>', nsn_opts)
remap("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", nsn_opts)
remap("n", "<leader>fG", '<cmd>lua require("telescope.builtin").git_files()<cr>', nsn_opts)
remap("n", "<leader>fg", '<cmd>lua require("telescope.builtin").live_grep()<cr>', nsn_opts)
remap("n", "<leader>fs", '<cmd>lua require("telescope.builtin").lsp_document_symbols()<cr>', nsn_opts)
remap("n", "<leader>fS", '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<cr>', nsn_opts)
-- =================================================================
-- SHORTCUTS FOR JUMP TO DEFINITION AND REFERENCE SET IN LSP CONFIG
-- =================================================================
-- remap("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', nsn_opts)
-- remap("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<CR>', nsn_opts)
-- remap("n", "<leader>fgs", '<cmd>lua require("telescope.builtin").git_status()<CR>', nsn_opts)
remap("n", "<leader>fr", '<cmd>lua require("telescope.builtin").resume()<CR>', nsn_opts)
-- map('n', '<leader>fg', ':Telescope live_grep<cr>', nsn_opts)
