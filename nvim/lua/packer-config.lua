local packer = require('packer')

packer.init{
  opt_default = false, -- Default to using opt (as opposed to start) plugins
  display = {
    non_interactive = false, -- If true, disable display windows for all operations
    open_fn  = require('packer.util').float, -- An optional function to open a window for packer's display
    open_cmd = '65vnew \\[packer\\]', -- An optional command to open a window for packer's display
    working_sym = '⟳', -- The symbol for a plugin being installed/updated
    error_sym = '✗', -- The symbol for a plugin with an error in installation/updating
    done_sym = '✓', -- The symbol for a plugin which has completed installation/updating
    removed_sym = '-', -- The symbol for an unused plugin which was removed
    moved_sym = '→', -- The symbol for a plugin which was moved (e.g. from opt to start)
    header_sym = '━', -- The symbol for the header line in packer's display
    show_all_info = true, -- Should packer show all update details automatically?
    prompt_border = 'double', -- Border style of prompt popups.
    keybindings = { -- Keybindings for the display window
      quit = 'q',
      toggle_info = '<CR>',
      diff = 'd',
      prompt_revert = 'r',
    }
  },
}

local use = packer.use
packer.reset()

packer.startup(function()
    -- == Package manager written in lua
    -- =============================================
    use 'wbthomason/packer.nvim'

    -- == Dashboard on startup and session management
    -- =============================================
    use 'glepnir/dashboard-nvim'

    -- == Treesitter
    -- =============================================
    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires= {
            -- == Text objects
            'nvim-treesitter/nvim-treesitter-textobjects',
            -- == Closing < tags
            'windwp/nvim-ts-autotag'
        }
    }

    -- == File explorer written in lua
    -- =============================================
    use 'kyazdani42/nvim-tree.lua'

    -- == Vim modifying surround to text
    -- =============================================
    use 'tpope/vim-surround'

    -- == Formatter
    -- =============================================
    use 'sbdchd/neoformat'

    -- == Commenting and uncommenting lines
    -- =============================================
    use 'b3nj5m1n/kommentary'

    -- == Auto Pairing parenthesis, brackets, etc...
    -- =============================================
    use 'jiangmiao/auto-pairs'

    -- == GIT
    -- =============================================
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
        },
    }

    -- == Indent blank lines
    -- =============================================
    use 'lukas-reineke/indent-blankline.nvim'

    -- == Fuzzy Finder
    -- =============================================
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
    }

    -- == LSP configuration
    -- =============================================
    use 'neovim/nvim-lspconfig'

    -- -- TOO BAD IT DOESN't HAVE HIGHLIGHT FOR DOCUMENTATION IN COMPLETION MENU
    -- use {'ms-jpq/coq_nvim',
    --     branch = 'coq',
    --     requires = {
    --         {'ms-jpq/coq.artifacts', branch = 'artifacts'},
    --         {'ms-jpq/coq.thirdparty', branch = '3p'}
    --     },
    -- }

    -- == Autocompletion
    -- =============================================
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'},
            {'SirVer/ultisnips'},
            {'onsails/lspkind-nvim'},
        }
    }

    -- == Allow comments in JSON
    -- (check JSON_allow_comments in init.lua)
    -- =============================================
    use 'neoclide/jsonc.vim'

    -- == Killing buffers easily
    -- =============================================
    use 'qpkorr/vim-bufkill'

    -- == My own branch of Sonokai theme
    -- Original is 'sainnhe/sonokai'
    -- =============================================
    use 'jorgebef/sonokai'

    -- == Useful status line and buffer line
    -- =============================================
    use 'nvim-lualine/lualine.nvim'
    use 'akinsho/bufferline.nvim'

    -- == KEEP DEVICONS LAST FOR CORRECT LOADING
    -- =============================================
    use 'kyazdani42/nvim-web-devicons'

end)
