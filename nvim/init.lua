-- ===================== THEMES ======================
vim.o.termguicolors = true

-- ===================== BASIC SETTINGS ======================
vim.o.backup = false
vim.o.writebackup = false
-- " Give more space for displaying messages.
vim.o.cmdheight = 2
vim.o.showcmd = true
vim.o.wildmenu = true
vim.o.mouse = ""
vim.o.showmatch = true
vim.o.expandtab = true
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.g.lazyredraw = true
vim.o.number = true
vim.o.ruler = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.signcolumn = "yes:1" -- Always show signcolumn, max width 1
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.shiftround = true
vim.o.sessionoptions = "globals,buffers,curdir,folds,help,resize,tabpages,winsize,winpos"
vim.o.smartcase = true
vim.o.tabstop = 2
vim.o.timeout = false
vim.o.timeoutlen = 10
vim.g.ttyfast = true
vim.o.undofile = true
vim.bo.undofile = true -- persistent undo is a neat feature
vim.o.updatetime = 600
vim.g.mapleader = " "
vim.o.wrapscan = true
vim.o.scrolloff = 3
vim.g.inccommand = "nosplit"
-- " Don't pass messages to |ins-completion-menu|.
vim.g.shortmess = vim.o.shortmess .. "c"

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
-- require('lua-ls')
require("bufferline-config")
require("bufdel-config")
-- require("startify-config")
require("treesitter-config")
require("null-ls-config")
require("telescope-config")
require("gitsigns-config")
require("dashboard-config")
-- require('diffview-config')
-- require("neoformat-config")
require("lightspeed-config")
require("colorizer-config")
-- require('toggleterm-config')
-- require('sonokai')
--require('fzf-config')
-- require('lua-ls.lua') -- luajit not yet available for M1 mac

vim.cmd("source ~/.config/nvim/vimscript/highlights.vim")
-- vim.cmd('source ~/.config/nvim/vimscript/coc-config.vim')

-- vim.cmd [[colorscheme sonokai]]
vim.g.catppuccin_flavour = "macchiato"
-- vim.g.catppuccin_flavour = "frappe"
-- vim.g.catppuccin_flavour = "dusk"
vim.cmd([[colorscheme catppuccin]])
