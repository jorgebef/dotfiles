-- ===================== THEMES ======================
vim.opt.termguicolors = true

-- ===================== BASIC SETTINGS ======================
vim.opt.backup = false
-- " Give more space for displaying messages.
vim.opt.showcmd = true
-- vim.o.wildmenu = true
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.lazyredraw = true
-- vim.o.ruler = true
-- vim.o.signcolumn = "yes:1" -- Always show signcolumn, max width 1
-- vim.opt.softtabstop = 2
-- vim.opt.shiftwidth = 2
-- vim.o.shiftround = true
vim.o.sessionoptions = "globals,buffers,curdir,folds,help,resize,tabpages,winsize,winpos"
-- vim.o.smartcase = true
-- vim.o.tabstop = 2
-- vim.o.timeout = false
-- vim.o.timeoutlen = 10
vim.g.ttyfast = true
-- vim.o.undofile = true
vim.bo.undofile = true -- persistent undo is a neat feature
-- vim.o.updatetime = 800
vim.g.mapleader = " "
-- vim.o.wrapscan = true
vim.g.inccommand = "nosplit"
-- " Don't pass messages to |ins-completion-menu|.
-- vim.g.shortmess = vim.o.shortmess .. "c"

vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999" -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "" --  don't allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2 -- always show tabs
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 450 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true -- set the title of window to the value of the titlestring
-- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
-- vim.opt.undodir = join_paths(get_cache_dir(), "undo") -- set an undo directory
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.cursorline = true -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = false -- set relative numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
-- vim.opt.wrap = false -- display lines as one long line
vim.opt.spell = false
vim.opt.spelllang = "en"
-- vim.opt.spellfile = join_paths(get_config_dir(), "spell", "en.utf-8.add")
-- vim.opt.shadafile = join_paths(get_cache_dir(), "lvim.shada")
vim.opt.scrolloff = 5 -- minimal number of screen lines to keep above and below the cursor.
-- vim.opt.sidescrolloff = 8 -- minimal number of screen lines to keep left and right of the cursor.

vim.opt.shortmess:append("c") -- don't show redundant messages from ins-completion-menu
vim.opt.shortmess:append("I") -- don't show the default intro message
vim.opt.whichwrap:append("<,>,[,],h,l")

-- ===================== NEOVIDE SETTINGS =============================
-- vim.g.neovide_cursor_animation_length=0
-- vim.cmd([[set guifont=JetBrainsMono\ Nerd\ Font:h13]])

vim.api.nvim_command("filetype plugin on")
vim.api.nvim_command("filetype indent plugin on")
vim.api.nvim_command("syntax on")

-- REMAPS
-- ================================================================
local remap = vim.keymap.set
local nsn_opts = { noremap = true, silent = true, nowait = true }
local ns_opts = { noremap = true, silent = true }
local n_opts = { noremap = true }
-- ================================================================

remap("n", "ñ", ";", { nowait = true })
remap("n", "Ñ", ":", { nowait = true })
remap("n", "'", "`", ns_opts)

-- " =========================== FUNCTIONAL REMAPS =============================
remap("n", "<leader>w", ":silent write<cr>", nsn_opts)
remap("n", "<leader>q", ":q<cr>", nsn_opts)

remap("v", "p", '"_dP', nsn_opts)

remap("n", "<leader>y", '"+y', nsn_opts)
remap("v", "<leader>y", '"+y', nsn_opts)

remap("n", "<leader>3", [["syiw<Esc>:let @/ = @s | set hls<CR>]], ns_opts)
remap("v", "<leader>3", [["sy<Esc>:let @/ = @s | set hls<CR>]], ns_opts)

-- SEARCH AND REPLACE
remap("n", "<leader>sr", ":.,$s/<C-r><C-w>//gc<Left><Left><Left>", n_opts)
remap("v", "<leader>sr", '"hy:.,$s/<C-r>h//gc<Left><Left><Left>', n_opts)

remap("n", "'", "`", ns_opts)

-- indenting and staying in indent mode
remap("v", "<", "<gv", ns_opts)
remap("v", ">", ">gv", ns_opts)
remap("n", "<leader>o", 'o<esc>0"_D<esc>', ns_opts)
remap("n", "<leader>O", 'O<esc>0"_D<esc>', ns_opts)

remap("n", "<esc>", ':noh<cr>:echo""<esc>', nsn_opts)

-- remap("n", "<leader>bd", ":b#|bd#<cr>", n_opts)
-- nvim_remap('n', '<leader>S', ':mksession!<cr>', { noremap = true, silent = false })
-- don't need this with vim-obsession

-- improved scrolling
remap("n", "<C-e>", "4<C-e>", nsn_opts)
remap("n", "<C-y>", "4<C-y>", nsn_opts)
remap("c", "<C-e>", "4<C-e>", nsn_opts)
remap("c", "<C-y>", "4<C-y>", nsn_opts)
remap("v", "<C-e>", "4<C-e>", nsn_opts)
remap("v", "<C-y>", "4<C-y>", nsn_opts)

-- improved split navigation
remap("n", "<C-j>", "<C-w>j", nsn_opts)
remap("n", "<C-k>", "<C-w>k", nsn_opts)
remap("n", "<C-l>", "<C-w>l", nsn_opts)
remap("n", "<C-h>", "<C-w>h", nsn_opts)

-- improved split manipulation
remap("n", "<C-S-j>", "<C-w>J", nsn_opts)
remap("n", "<C-S-k>", "<C-w>K", nsn_opts)
remap("n", "<C-S-l>", "<C-w>L", nsn_opts)
remap("n", "<C-S-h>", "<C-w>H", nsn_opts)

remap("n", "<leader>=", "<C-w>=", nsn_opts)
remap("n", "<leader>+", "<C-w>8>", nsn_opts)
remap("n", "<leader>-", "<C-w>8<", nsn_opts)

remap("n", "<leader>V", ":vs<CR>", nsn_opts)

-- " ====================== AUTOCMD ========================

-- vim.api.nvim_exec(
-- 	[[
--   autocmd FileType json syntax match Comment +\/\/.\+$+
--   ]],
-- 	false
-- )

vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = "*",
	command = 'lua vim.highlight.on_yank { higroup="IncSearch", timeout=250 }',
	group = "highlight_yank",
})

vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd(
	{ "VimEnter", "WinEnter", "BufRead", "BufWinEnter" },
	{ pattern = "*", command = 'setlocal cursorline | :echo""', group = "CursorLine" }
)
vim.api.nvim_create_autocmd({ "WinLeave" }, { pattern = "*", command = "setlocal nocursorline", group = "CursorLine" })

-- " ====================== / AUTOCMD ========================

-- ======================== REQUIRE EXTRA FILES ===================
require("packer-config")
require("catppuccin-config")
require("lsp-config")
require("nvim-cmp-config")
require("luasnip-config")
require("indentline-config")
require("comment-config")
require("nvim-tree-config")
require("lualine-config")
require("bufferline-config")
require("bufdel-config")
require("treesitter-config")
require("null-ls-config")
require("telescope-config")
require("gitsigns-config")
require("dashboard-config")
require("lightspeed-config")
require("colorizer-config")

vim.cmd("source ~/.config/nvim/vimscript/highlights.vim")
-- vim.cmd('source ~/.config/nvim/vimscript/coc-config.vim')

-- vim.cmd [[colorscheme sonokai]]
vim.g.catppuccin_flavour = "macchiato"
-- vim.g.catppuccin_flavour = "frappe"
-- vim.g.catppuccin_flavour = "dusk"
vim.cmd([[colorscheme catppuccin]])
