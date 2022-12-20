local lazy_plugin_manager = require("lazy")
local ui = require("jbef.ui")

local opts = {
	root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
	defaults = {
		lazy = false, -- should plugins be lazy-loaded?
		version = nil,
		-- version = "*", -- enable this to try installing the latest stable versions of plugins
	},
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
	concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
	git = {
		-- defaults for the `Lazy log` command
		-- log = { "-10" }, -- show the last 10 commits
		log = { "--since=3 days ago" }, -- show commits from the last 3 days
		timeout = 120, -- kill processes that take more than 2 minutes
		url_format = "https://github.com/%s.git",
	},
	dev = {
		-- directory where you store your local plugin projects
		path = "~/projects",
		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
		patterns = {}, -- For example {"folke"}
	},
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "habamax" },
	},
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
	checker = {
		-- automatically check for plugin updates
		enabled = false,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = true, -- get a notification when changes are found
	},
	performance = {
		cache = {
			enabled = true,
			path = vim.fn.stdpath("state") .. "/lazy/cache",
			-- Once one of the following events triggers, caching will be disabled.
			-- To cache all modules, set this to `{}`, but that is not recommended.
			-- The default is to disable on:
			--  * VimEnter: not useful to cache anything else beyond startup
			--  * BufReadPre: this will be triggered early when opening a file from the command line directly
			disable_events = { "VimEnter", "BufReadPre" },
		},
		reset_packpath = true, -- reset the package path to improve startup time
		rtp = {
			reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
			---@type string[] list any plugins you want to disable here
			disabled_plugins = {
				-- "gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				-- "tarPlugin",
				-- "tohtml",
				-- "tutor",
				-- "zipPlugin",
			},
		},
	},
	-- lazy can generate helptags from the headings in markdown readme files,
	-- so :help works even for plugins that don't have vim docs.
	-- when the readme opens with :help it will be correctly displayed as markdown
	readme = {
		root = vim.fn.stdpath("state") .. "/lazy/readme",
		files = { "README.md" },
		-- only generate markdown helptags for plugins that dont have docs
		skip_if_doc_exists = true,
	},
}

vim.cmd([[ 
  let  g:tmux_navigator_no_wrap = 1
  ]])

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
