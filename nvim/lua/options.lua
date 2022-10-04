local o = vim.opt
local g = vim.g

-- ================== USE SYSTEM CLIPBOARD ==================
-- local is_mac = vim.fn.has("macunix")
-- if is_mac then
-- 	vim.opt.clipboard:append({ "unnamedplus" })
-- end

-- ===================== BASIC SETTINGS ======================
o.backup = false
o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
-- " Give more space for displaying messages.
o.showcmd = true
o.wildmenu = true
o.showmatch = true
o.incsearch = true
o.lazyredraw = true
o.sessionoptions = "globals,buffers,curdir,folds,help,resize,tabpages,winsize,winpos"
-- vim.g.ttyfast = true
g.inccommand = "nosplit"

-- WAITING FOR 0.8!!!!!!!!!!!!!
-- vim.o.winbar = "%{%v:lua.require('utils.winbar_new').get_winbar()%}"

-- ==================================
o.completeopt = { "menu", "menuone", "noselect" }
o.conceallevel = 0 -- so that `` is visible in markdown files
-- o.fileencoding = "utf-8" -- the encoding written to a file
-- o.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
-- o.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
-- o.guifont = "monospace:h17" -- the font used in graphical neovim applications
o.hidden = true -- required to keep multiple buffers and open multiple buffers
o.hlsearch = true -- highlight all matches on previous search pattern
o.showtabline = 0 -- never show tabs
o.swapfile = false -- creates a swapfile
vim.opt.title = true -- set the title of window to the value of the titlestring
-- o.undodir = join_paths(get_cache_dir(), "undo") -- set an undo directory
o.expandtab = true -- convert tabs to spaces
-- o.spell = false
o.scrolloff = 2 -- minimal number of screen lines to keep above and below the cursor.

o.laststatus = 3 -- global statusline
o.title = true
o.cul = true -- cursor line
o.showmode = false
-- o.cmdheight = 0 -- Thanks shougo

-- Indentline
o.shiftwidth = 2
o.smartindent = true

-- disable tilde on end of buffer: https://github.com/neovim/neovim/pull/8546#issuecomment-643643758
o.fillchars = { eob = " " }

o.ignorecase = true
o.smartcase = true
o.mouse = ""

-- Numbers
o.number = true
o.numberwidth = 2
o.relativenumber = true
o.ruler = false

-- disable nvim intro
o.shortmess:append("sI")

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.tabstop = 2
o.termguicolors = true
o.timeoutlen = 550
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 550

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
o.whichwrap:append("<>[]hl")
g.mapleader = " "

g.python_recommended_style = 0
g.tex_flavor = "latex"
o.pumheight = 15
o.linebreak = true
