local packer = require("packer")

packer.init({
	opt_default = false, -- Default to using opt (as opposed to start) plugins
	display = {
		non_interactive = false, -- If true, disable display windows for all operations
		open_fn = require("packer.util").float, -- An optional function to open a window for packer's display
		open_cmd = "65vnew \\[packer\\]", -- An optional command to open a window for packer's display
		working_sym = "⟳", -- The symbol for a plugin being installed/updated
		error_sym = "✗", -- The symbol for a plugin with an error in installation/updating
		done_sym = "✓", -- The symbol for a plugin which has completed installation/updating
		removed_sym = "-", -- The symbol for an unused plugin which was removed
		moved_sym = "→", -- The symbol for a plugin which was moved (e.g. from opt to start)
		header_sym = "━", -- The symbol for the header line in packer's display
		show_all_info = true, -- Should packer show all update details automatically?
		prompt_border = "double", -- Border style of prompt popups.
		keybindings = { -- Keybindings for the display window
			quit = "q",
			toggle_info = "<CR>",
			diff = "d",
			prompt_revert = "r",
		},
	},
})

local use = packer.use
packer.reset()

packer.startup(function()
	-- == Package manager written in lua
	-- =============================================
	use("wbthomason/packer.nvim")

	-- == Filetype detection in lua
	-- =============================================
	use("nathom/filetype.nvim")

	-- == Dashboard on startup and session management
	-- =============================================
	use("glepnir/dashboard-nvim")

	-- == Treesitter
	-- =============================================
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			-- == Text objects
			-- 'nvim-treesitter/nvim-treesitter-textobjects',
			-- == Closing < tags
			"windwp/nvim-ts-autotag",
			-- == context-aware commenting
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	})
	use("nvim-treesitter/playground")

	-- == Commenting and uncommenting lines
	-- =============================================
	use("numToStr/Comment.nvim")
	-- use 'b3nj5m1n/kommentary'

	-- == File explorer written in lua
	-- =============================================
	use("kyazdani42/nvim-tree.lua")

	-- == Vim modifying surround to text
	-- =============================================
	use("tpope/vim-surround")

	-- == Formatter
	-- =============================================
	use("sbdchd/neoformat")

	-- == Colorizer
	-- =============================================
	use("norcalli/nvim-colorizer.lua")

	-- == Auto Pairing parenthesis, brackets, etc...
	-- =============================================
	use("windwp/nvim-autopairs")
	require("nvim-autopairs").setup({
		enable_check_bracket_line = false,
	})

	-- == git signs and staging ==
	-- =============================================
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
	})
	-- use { 'tpope/vim-fugitive' }

	-- == Indent blank lines
	-- =============================================
	use("lukas-reineke/indent-blankline.nvim")

	-- == Fuzzy Finder
	-- =============================================
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope-project.nvim" })

	--   use {
	--     'ibhagwan/fzf-lua',
	--   requires = {
	--       'kyazdani42/nvim-web-devicons'
	--     }
	-- }
	-- ============================================

	-- == LSP configuration
	-- =============================================
	use("neovim/nvim-lspconfig")
	-- == Autocompletion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			-- {'SirVer/ultisnips'},
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
			{ "onsails/lspkind-nvim" },
		},
	})

	-- == Allow comments in JSON
	-- (check JSON_allow_comments in init.lua)
	-- =============================================
	use("neoclide/jsonc.vim")

	-- == Killing buffers easily
	-- =============================================
	-- use 'qpkorr/vim-bufkill'
	use({ "ojroques/nvim-bufdel" })

	-- == Catppuccin theme
	-- =============================================
	use({
		"catppuccin/nvim",
		-- "jorgebef/nvim",
		branch = "main",
		-- branch = "experiments",
		as = "catppuccin",
	})

	-- == Useful status line and buffer line
	-- =============================================
	use("nvim-lualine/lualine.nvim")
	use("akinsho/bufferline.nvim")

	-- == LIGHTSPEED ==
	-- =============================================
	use("ggandor/lightspeed.nvim")

	-- == KEEP DEVICONS LAST FOR CORRECT LOADING
	-- =============================================
	use("kyazdani42/nvim-web-devicons")
end)
