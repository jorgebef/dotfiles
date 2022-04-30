require("bufferline").setup({
	options = {
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 18,
		-- indicator_icon = '▎',
		-- indicator_icon = '█',
		-- indicator_icon = '',
		indicator_icon = "",
		modified_icon = "",
		diagnostics_update_in_insert = false,
		-- NOTE: this will be called a lot so don't do any heavy processing here
		show_buffer_icons = true, -- disable filetype icons for buffers
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = false,
		separator_style = "thin",
		-- separator_style = 'slant',
		-- separator_style = { ' ', ' ' },
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		offsets = { { filetype = "NvimTree" } },
		always_show_bufferline = true,
	},
	highlights = {
		indicator_selected = {
			guifg = "#F5BFE7",
		},
		modified = {
			guifg = "#F67E98",
		},
		modified_visible = {
			guifg = "#F67E98",
		},
		modified_selected = {
			guifg = "#F67E98",
		},
	},
})

-- =======================================================================
-- ============================== REMAPS =================================
-- =======================================================================

local remap = vim.api.nvim_set_keymap
local nsn_opts = { noremap = true, silent = true, nowait = true }
remap("n", "<C-n>", ":BufferLineCycleNext<CR>", nsn_opts)
remap("n", "<C-p>", ":BufferLineCyclePrev<CR>", nsn_opts)
remap("n", "<C-S-n>", ":BufferLineMoveNext<CR>", nsn_opts)
remap("n", "<C-S-p>", ":BufferLineMovePrev<CR>", nsn_opts)
