local lazy_plugin_manager = require("lazy")
local ui = require("jbef.ui")

local opts = {
	ui = {
		-- a number <1 is a percentage., >1 is a fixed size
		size = { width = 0.8, height = 0.8 },
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = ui.border.Single,
		-- border = "none",
		icons = {
			cmd = " ",
			config = "",
			event = "",
			ft = " ",
			init = " ",
			keys = " ",
			plugin = " ",
			runtime = " ",
			source = " ",
			start = "",
			task = "✔ ",
		},
		throttle = 20, -- how frequently should the ui process render events
	},
}

lazy_plugin_manager.setup({
	{ "wbthomason/packer.nvim" },

	{ "christoomey/vim-tmux-navigator" },
	-- == Dashboard on startup
	-- =======================
	{ "glepnir/dashboard-nvim" },

	-- Session manager
	-- =======================
	{ "Shatur/neovim-session-manager" },

	-- == Treesitter
	-- =======================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			-- == Text objects
			"nvim-treesitter/nvim-treesitter-textobjects",
			-- == Closing < tags
			"windwp/nvim-ts-autotag",
			-- == context-aware commenting
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/playground",
		},
	},

	-- == File explorer written in lua
	-- =======================
	{ "kyazdani42/nvim-tree.lua" },

	{ "echasnovski/mini.nvim" },

	-- == Surround tool
	-- =======================
	{ "kylechui/nvim-surround" },

	-- use("norcalli/nvim-colorizer.lua")
	-- =======================
	{ "NvChad/nvim-colorizer.lua" },

	-- == Auto Pairing parenthesis, brackets, etc...
	-- =======================
	{ "windwp/nvim-autopairs" },

	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
	},
	{ "lukas-reineke/indent-blankline.nvim" },

	-- Fuzzy Finder
	-- =======================
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
	-- =======================
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "jose-elias-alvarez/nvim-lsp-ts-utils" },
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "glepnir/lspsaga.nvim", branch = "main" },
			{ "SmiteshP/nvim-navic" },
		},
	},

	-- Autocompletion
	-- =======================
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

	-- == Easier navigation around
	-- =======================
	{ "ggandor/leap.nvim" },

	{ "tpope/vim-repeat" },

	{ "folke/which-key.nvim" },

	{
		"catppuccin/nvim",
		branch = "main",
		name = "catppuccin",
		build = ":CatppuccinCompile",
	},

	{ "nvim-lualine/lualine.nvim" },

	-- == KEEP DEVICONS LAST FOR CORRECT LOADING
	{ "kyazdani42/nvim-web-devicons" },
}, opts)
