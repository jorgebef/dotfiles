require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	-- ignore_install = { "javascript" }, -- List of parsers to ignore installing
	-- textobjects = {
	--     move = {
	--         enable = true,
	--         set_jumps = true,
	--         goto_next_start = {
	--             ["]m"] = "@function.outer",
	--             ["[["] = "@parameter.inner",
	--         },
	--         goto_previous_start = {
	--             ["[M"] = "@function.outer",
	--             ["]]"] = "@parameter.inner",
	--         },
	--         goto_next_end = {
	--             ["]M"] = "@function.outer",
	--             ["]["] = "@class.outer",
	--         },
	--         goto_previous_end = {
	--             ["[M"] = "@function.outer",
	--             ["[]"] = "@class.outer",
	--         },
	--     },
	--     select = {
	--         enable = true,
	--         lookahead = true,
	--         keymaps = {
	--             ["af"] = "@function.outer",
	--             ["if"] = "@function.inner",
	--             ["ac"] = "@class.outer",
	--             ["ic"] = "@class.inner",
	--             ["iq"] = "@parameter.inner",
	--             ["aq"] = "@parameter.outer",
	--         },
	--     },
	-- },
	highlight = {
		enable = true, -- false will disable the whole extension
		-- disable = { "c", "rust" },  -- list of language that will be disabled
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	playground = {
		enable = false,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
	indent = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
