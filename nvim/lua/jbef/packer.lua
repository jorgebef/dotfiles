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
	-- =======================
	use("wbthomason/packer.nvim")

	use("christoomey/vim-tmux-navigator")
	vim.cmd([[ 
  let  g:tmux_navigator_no_wrap = 1
  ]])

	-- == Dashboard on startup
	-- =======================
	use("glepnir/dashboard-nvim")

	-- Session manager
	-- =======================
	use({ "Shatur/neovim-session-manager" })

	-- == Treesitter
	-- =======================
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			-- == Text objects
			"nvim-treesitter/nvim-treesitter-textobjects",
			-- == Closing < tags
			"windwp/nvim-ts-autotag",
			-- == context-aware commenting
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/playground",
		},
	})

	-- == File explorer written in lua
	-- =======================
	use("kyazdani42/nvim-tree.lua")

	use("echasnovski/mini.nvim")

	-- == Surround tool
	-- =======================
	use({ "kylechui/nvim-surround" })

	-- use("norcalli/nvim-colorizer.lua")
	-- =======================
	use("NvChad/nvim-colorizer.lua")

	-- == Auto Pairing parenthesis, brackets, etc...
	-- =======================
	use("windwp/nvim-autopairs")
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
	})
	use("lukas-reineke/indent-blankline.nvim")

	-- Fuzzy Finder
	-- =======================
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "natecraddock/telescope-zf-native.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	})

	-- LSP
	-- =======================
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })

	use({
		"neovim/nvim-lspconfig",
		requires = {
			{ "jose-elias-alvarez/nvim-lsp-ts-utils" },
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "glepnir/lspsaga.nvim", branch = "main" },
			{ "SmiteshP/nvim-navic" },
		},
	})

	-- Autocompletion
	-- =======================
	use({
		"hrsh7th/nvim-cmp",
		requires = {
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
	})

	use("mbbill/undotree")

	-- == Easier navigation around
	-- =======================
	use("ggandor/leap.nvim")

	use("tpope/vim-repeat")

	use("folke/which-key.nvim")

	use({
		"catppuccin/nvim",
		branch = "main",
		as = "catppuccin",
		run = ":CatppuccinCompile",
	})

	use("nvim-lualine/lualine.nvim")

	-- == KEEP DEVICONS LAST FOR CORRECT LOADING
	use("kyazdani42/nvim-web-devicons")
end)
