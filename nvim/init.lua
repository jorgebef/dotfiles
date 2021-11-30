-- ===================== THEMES ======================
vim.o.termguicolors = true
-- vim.g.sonokai_disable_italic_comment=1
-- vim.g.sonokai_style='default'
vim.g.sonokai_style='belf'
-- vim.g.sonokai_enable_italic=1
-- vim.cmd [[colorscheme onedarker]]

-- ===================== BASIC SETTINGS ======================
vim.o.backup = false
vim.o.writebackup = false
-- " Give more space for displaying messages.
vim.o.cmdheight = 2
vim.o.showcmd = true
vim.o.wildmenu = true
vim.o.mouse = ''
vim.o.showmatch = true
vim.o.expandtab = true
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.number = true
vim.o.ruler = true
vim.o.showmode = false
vim.o.signcolumn = "yes:1" -- Always show signcolumn, max width 1
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.sessionoptions = 'globals,buffers,curdir,folds,help,resize,tabpages,winsize,winpos'
vim.o.smartcase = true
vim.o.tabstop = 4
vim.o.timeout = false
vim.o.timeoutlen = 10
vim.o.undofile = true; vim.bo.undofile = true -- persistent undo is a neat feature
vim.o.updatetime = 600
vim.g.mapleader = ' '
vim.o.wrapscan = true
vim.o.scrolloff = 4
-- " Don't pass messages to |ins-completion-menu|.
vim.g.shortmess = vim.o.shortmess .. 'c'

-- REMAPS
-- ================================================================
local remap = vim.api.nvim_set_keymap
local nsn_opts = { noremap = true, silent = true, nowait = true }
local ns_opts = { noremap = true, silent = true }
local n_opts = { noremap = true }
-- ================================================================

remap('n', 'ñ', ';', { nowait = true})
remap('n', 'Ñ', ':', { nowait = true })
remap('n', "'", '`', ns_opts)

-- " =========================== FUNCTIONAL REMAPS =============================
remap('n', '<leader>w', ':silent write<cr>', nsn_opts)

remap('n', '<leader>3', [["syiw<Esc>:let @/ = @s | set hls<CR>]], ns_opts)
remap('v', '<leader>3', [["sy<Esc>:let @/ = @s | set hls<CR>]], ns_opts)

-- SEARCH AND REPLACE
remap('n', '<leader>sr', ':.,$s/<C-r><C-w>//gc<Left><Left><Left>', n_opts)
remap('v', '<leader>sr', '"hy:.,$s/<C-r>h//gc<Left><Left><Left>', n_opts)

remap('n', "'", '`', ns_opts)

remap('n', '<', '<gv', ns_opts)
remap('n', '>', '>gv', ns_opts)
remap('n', '<leader>o', 'o<esc>0"_D<esc>', ns_opts)
remap('n', '<leader>O', 'O<esc>0"_D<esc>',  ns_opts)

remap('n', '<esc>', ':noh<cr>:echo""<esc>', nsn_opts)

-- nvim_remap('n', '<leader>S', ':mksession!<cr>', { noremap = true, silent = false })
-- don't need this with vim-obsession

-- " Scroll 4 lines with <C-e>, improved scrolling
remap('n', '<C-e>', '4<C-e>', nsn_opts)
remap('n', '<C-y>', '4<C-y>', nsn_opts)
remap('c', '<C-e>', '4<C-e>', nsn_opts)
remap('c', '<C-y>', '4<C-y>', nsn_opts)
remap('v', '<C-e>', '4<C-e>', nsn_opts)
remap('v', '<C-y>', '4<C-y>', nsn_opts)

remap('n', '<leader>j', '<C-w>j', nsn_opts)
remap('n', '<leader>k', '<C-w>k', nsn_opts)
remap('n', '<leader>l', '<C-w>l', nsn_opts)
remap('n', '<leader>h', '<C-w>h', nsn_opts)

remap('n', '<leader>J', '<C-w>J', nsn_opts)
remap('n', '<leader>K', '<C-w>K', nsn_opts)
remap('n', '<leader>L', '<C-w>L', nsn_opts)
remap('n', '<leader>H', '<C-w>H', nsn_opts)

remap('n', '<leader>=', '<C-w>=', nsn_opts)
remap('n', '<leader>+', '<C-w>10>', nsn_opts)
remap('n', '<leader>-', '<C-w>10<', nsn_opts)

-- nvim_remap('n', '<leader>n', ':bnext<CR>', nsn_opts)
-- nvim_remap('n', '<leader>p', ':bprevious<CR>', nsn_opts)


-- " ====================== AUTOCMD ========================

vim.api.nvim_exec(
  [[
    augroup CursorLine
      autocmd!
      au VimEnter,WinEnter,BufRead,BufWinEnter * setlocal cursorline | :echo""
      au WinLeave * setlocal nocursorline
    augroup END

    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=250 }
    augroup END


  ]],
  false
)

-- " ====================== / AUTOCMD ========================

-- ======================= Highlight groups ======================================
vim.api.nvim_exec([[
    function! MyHighlights() abort

        let l:pal = sonokai#get_palette('belf')


        call sonokai#highlight('Pmenu', l:pal.fg, l:pal.bg1)
        call sonokai#highlight('NormalFloat', l:pal.fg, l:pal.bg1)
        call sonokai#highlight('FloatBorder', l:pal.grey, l:pal.bg1)
        call sonokai#highlight('IndentBlanklineContextChar', l:pal.fg, l:pal.none)
        call sonokai#highlight('IndentBlanklineChar', l:pal.bg4, l:pal.none)
        call sonokai#highlight('DiagnosticSignError', l:pal.red, l:pal.none)
        call sonokai#highlight('DiagnosticSignWarning', l:pal.orange, l:pal.none)
        call sonokai#highlight('DiagnosticSignInformation', l:pal.yellow, l:pal.none)
        call sonokai#highlight('DiagnosticSignHint', l:pal.blue, l:pal.none)

        hi! link DiagnosticVirtualTextError DiagnosticSignError
        hi! link DiagnosticFloatingError DiagnosticSignError

        hi! link DiagnosticVirtualTextWarning DiagnosticSignWarning
        hi! link DiagnosticFloatingWarning DiagnosticSignWarning

        hi! link DiagnosticVirtualTextInformation DiagnosticSignInformation
        hi! link DiagnosticFloatingInformation DiagnosticSignInformation

        hi! link DiagnosticVirtualTextHint DiagnosticSignHint
        hi! link DiagnosticFloatingHint DiagnosticSignHint

    endfunction

    augroup JSON_allow_comments
        autocmd!
        autocmd BufNewFile,BufRead coc-settings.json setlocal filetype=jsonc
        autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
    augroup END

    augroup MyColors
        autocmd!
        autocmd ColorScheme sonokai call MyHighlights()
    augroup END

]],false)

vim.cmd [[colorscheme sonokai]]

-- ======================== REQUIRE EXTRA FILES ===================
require('packer-config')
require('lsp-config')
require('completion-config')
require('indentline-config')
require('kommentary-config')
require('nvim-tree-config')
require('lualine-config')
-- require('lua-ls')
-- require('lspsaga-config')
require('bufferline-config')
require('startify-config')
require('treesitter-config')
require('telescope-config')
require('gitsigns-config')
require('dashboard-config')
require('diffview-config')
require('neoformat-config')
-- require('sonokai')
--require('fzf-config')
-- require('lua-ls.lua') -- luajit not yet available for M1 mac
