---@class vim.opt
local opt = vim.opt

-- ================== USE SYSTEM CLIPBOARD ==================
-- local is_mac = vim.fn.has("macunix")
-- if is_mac then
-- 	vim.opt.clipboard:append({ "unnamedplus" })
-- end

-- ===================== BASIC SETTINGS ======================
opt.backup = false
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
-- " Give more space for displaying messages.
opt.showcmd = true
opt.wildmenu = true
opt.showmatch = true
opt.incsearch = true
-- opt.lazyredraw = true
opt.sessionoptions = "globals,buffers,curdir,folds,help,resize,tabpages,winsize,winpos"
-- vim.g.ttyfast = true
vim.g.inccommand = "nosplit"

-- ==================================
opt.completeopt = { "menu", "menuone", "noselect" }
opt.conceallevel = 0 -- so that `` is visible in markdown files
-- o.fileencoding = "utf-8" -- the encoding written to a file
-- o.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
-- o.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
-- o.guifont = "monospace:h17" -- the font used in graphical neovim applications
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.showtabline = 0 -- never show tabs
opt.swapfile = false -- creates a swapfile
vim.opt.title = true -- set the title of window to the value of the titlestring
-- o.undodir = join_paths(get_cache_dir(), "undo") -- set an undo directory
opt.expandtab = true -- convert tabs to spaces
-- o.spell = false
opt.scrolloff = 1 -- minimal number of screen lines to keep above and below the cursor.

opt.laststatus = 3 -- global statusline
opt.title = true
opt.cul = true -- cursor line
opt.showmode = false
-- opt.cmdheight = 0 -- Thanks shougo
opt.iskeyword:remove("_") -- make underscore not be part of word
-- vim.cmd([[set iskeyword-=_]]) -- same as above

-- Indentline
opt.shiftwidth = 2
opt.smartindent = true

-- disable tilde on end of buffer: https://github.com/neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = { eob = " " }

opt.ignorecase = true
opt.smartcase = true
opt.mouse = ""

-- Numbers
opt.number = true
opt.numberwidth = 4
opt.relativenumber = true
opt.ruler = false

-- Status column - NEW from 0.9
-- handled in lua/util/status_column.lua
vim.opt.statuscolumn = [[%!v:lua.require'util.status_column'.statuscolumn()]]
-- require("util.status_column")

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes:1"
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 950
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 550
-- opt.updatetime = 850

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

vim.g.python_recommended_style = 0
vim.g.tex_flavor = "latex"
opt.pumheight = 15
opt.linebreak = true
