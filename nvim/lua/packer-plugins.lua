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
    use 'wbthomason/packer.nvim'

    use 'mhinz/vim-startify'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- TreeSitter
    use 'kyazdani42/nvim-tree.lua' -- Tree viewer as file explorer
    -- ==== Vim modifying surround to text ====
    use 'tpope/vim-surround'
    -- ==== Commenting and uncommenting lines ====
    use 'tpope/vim-commentary'
    -- ==== Closing < tags ====
    use 'alvan/vim-closetag'
    -- ==== Auto Pairing parenthesis, brackets, etc... ====
    use 'jiangmiao/auto-pairs'
    -- ==== VIM Gutter ====
    -- use 'airblade/vim-gitgutter'
    -- ==== GIT CONTROL
    -- use 'tpope/vim-fugitive'
    -- Indent blank lines
    use 'lukas-reineke/indent-blankline.nvim'
    -- FZF
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
    }
    use 'neovim/nvim-lspconfig'

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'},
            {'onsails/lspkind-nvim'},
        }
    }
    -- use 'glepnir/lspsaga.nvim'
    --use 'hrsh7th/cmp-vsnip'
    --use 'hrsh7th/vim-vsnip'
    --use 'L3MON4D3/LuaSnip'
    use 'SirVer/ultisnips'
    -- ==== Killing buffers easily ====
    use 'qpkorr/vim-bufkill'
    -- Auto save session on exits
    use 'tpope/vim-obsession'
    -- ==== My own branch of Sonokai theme ====
    use 'sainnhe/sonokai'
    -- nice airline-like plugin
    use 'nvim-lualine/lualine.nvim'
    use 'akinsho/bufferline.nvim'
    -- use 'voldikss/vim-floaterm'
    -- === KEEP DEVICONS IN LAST POSITION FOR CORRECT LOADING
    use 'kyazdani42/nvim-web-devicons'

end)
