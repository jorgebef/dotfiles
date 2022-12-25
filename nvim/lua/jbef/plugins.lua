local lazy_plugin_manager = require("lazy")
local ui = require("jbef.ui")

local opts = {
	ui = {
		-- a number <1 is a percentage., >1 is a fixed size
		size = { width = 0.8, height = 0.8 },
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = ui.border.Single,
	},
}

lazy_plugin_manager.setup({
	{ "christoomey/vim-tmux-navigator" },
	{ "glepnir/dashboard-nvim" }, -- Dashboard on startup
	{ "Shatur/neovim-session-manager" }, -- Session manager

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects", -- Text objects
			"windwp/nvim-ts-autotag", -- Closing < tags
			"JoosepAlviste/nvim-ts-context-commentstring", -- context-aware commenting
			"nvim-treesitter/playground",
		},
	},

	{ "kyazdani42/nvim-tree.lua" }, -- File explorer written in lua
	{ "echasnovski/mini.nvim" }, -- Several small plugins in one
	{ "kylechui/nvim-surround" }, -- Surround tool
	{ "NvChad/nvim-colorizer.lua" }, -- Colorizer
	{ "windwp/nvim-autopairs" }, -- Auto Pairing parenthesis, brackets, etc...

	{ "andymass/vim-matchup" },

	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
	},

	{ "lukas-reineke/indent-blankline.nvim" },

	-- Fuzzy Finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "natecraddock/telescope-zf-native.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "jose-elias-alvarez/nvim-lsp-ts-utils" },
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "glepnir/lspsaga.nvim", branch = "main" },
			{ "SmiteshP/nvim-navic" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "saadparwaiz1/cmp_luasnip" },
			-- {'SirVer/ultisnips'},
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
			{ "onsails/lspkind-nvim" },
		},
	},

	{ "mbbill/undotree" },

	{ "ggandor/leap.nvim" }, -- Easier navigation around
	{ "tpope/vim-repeat" },

	{ "folke/which-key.nvim" },
	{
		"catppuccin/nvim",
		branch = "main",
		name = "catppuccin",
		build = ":CatppuccinCompile",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},

	{ "nvim-lualine/lualine.nvim" },

	{ "kyazdani42/nvim-web-devicons" }, -- Cool icons
}, opts)
