local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
	filepath = vim.fn.expand(filepath)
	Job
		:new({
			command = "file",
			args = { "--mime-type", "-b", filepath },
			on_exit = function(j)
				local mime_type = vim.split(j:result()[1], "/")[1]
				if mime_type == "text" then
					previewers.buffer_previewer_maker(filepath, bufnr, opts)
				else
					-- maybe we want to write something to the buffer here
					vim.schedule(function()
						vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
					end)
				end
			end,
		})
		:sync()
end

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
			},
		},
	},
	defaults = {
		-- prompt_prefix = "   ",
		prompt_prefix = "   ",
		selection_caret = " ",
		-- buffer_previewer_maker = new_maker,
		-- ====================================================
		-- IT IS VERY SLOW TO RELY ON FILE IGNORE PATTERNS
		-- ====================================================
		file_ignore_patterns = {
			"node_modules/",
			".git/",
			".next/",
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
		project = {},
	},
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")

-- =======================================================================
-- ============================== REMAPS =================================
-- =======================================================================

local remap = vim.api.nvim_set_keymap
local nsn_opts = { noremap = true, silent = true, nowait = true }
remap("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files({sort_lastused=true})<cr>', nsn_opts)
remap("n", "<leader>fF", '<cmd>lua require("telescope-functions").project_files()<cr>', nsn_opts)
remap("n", "<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<cr>', nsn_opts)
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
