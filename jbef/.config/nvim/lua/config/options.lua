-- ================== USE SYSTEM CLIPBOARD ==================
-- local is_mac = vim.fn.has("macunix")
-- if is_mac then
-- 	vim.opt.clipboard:append({ "unnamedplus" })
-- end

-- ===================== BASIC SETTINGS ======================
vim.g.mapleader = " "
vim.opt.backup = false
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
-- " Give more space for displaying messages.
vim.opt.showcmd = true
-- vim.opt.wildmenu = true
vim.opt.showmatch = true
vim.opt.synmaxcol = 300 -- stop syntax highlighting for performance
vim.opt.incsearch = true
-- opt.lazyredraw = true
vim.opt.sessionoptions = "globals,buffers,curdir,folds,help,resize,tabpages,winsize,winpos"
-- vim.g.ttyfast = true
-- vim.g.inccommand = "nosplit"

-- ==================================
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
-- o.fileencoding = "utf-8" -- the encoding written to a file

-- -- Folds ======================================================================
-- vim.o.foldmethod = "indent" -- Set 'indent' folding method
-- vim.o.foldlevel = 10 -- Display all folds except top ones
-- vim.o.foldnestmax = 20 -- Create folds only for some number of nested levels
-- vim.g.markdown_folding = 1 -- Use folding by heading in markdown files

if vim.fn.has("nvim-0.10") == 1 then
  vim.o.foldtext = "" -- Use underlying text with its highlighting
end

-- vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
-- o.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding

-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- o.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.showtabline = 0 -- never show tabs
vim.opt.swapfile = false -- creates a swapfile
vim.opt.title = true -- set the title of window to the value of the titlestring
-- o.undodir = join_paths(get_cache_dir(), "undo") -- set an undo directory
vim.opt.expandtab = true -- convert tabs to spaces
-- o.spell = false
vim.opt.scrolloff = 3 -- minimal number of screen lines to keep above and below the cursor.

vim.opt.laststatus = 2 -- global statusline
vim.opt.title = true
-- vim.opt.cursorline = true -- cursor line
-- vim.opt.showmode = false -- has no effect when 'cmdheight' is 0
vim.opt.cmdheight = 1 -- Thanks shougo
-- opt.iskeyword:remove("_") -- make underscore not be part of word
-- vim.cmd([[set iskeyword-=_]]) -- same as above

-- Indentline
vim.opt.shiftwidth = 2
vim.opt.smartindent = true

-- disable tilde on end of buffer: https://github.com/neovim/neovim/pull/8546#issuecomment-643643758

vim.o.fillchars = table.concat(
  -- Special UI symbols
  {
    "eob: ",
    "fold:╌",
    horiz = "━",
    vert = "┃",
    horizdown = "┳",
    horizup = "┻",
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
    -- "horiz:═",
    -- "horizdown:╦",
    -- "horizup:╩",
    -- "vert:║",
    -- "verthoriz:╬",
    -- "vertleft:╣",
    -- "vertright:╠",
  },
  ","
)
-- vim.opt.fillchars = {
--   horiz = "━",
--   vert = "┃",
--   horizdown = "┳",
--   horizup = "┻",
--   vertleft = "┫",
--   vertright = "┣",
--   verthoriz = "╋",
--   eob = " ",
-- }

vim.o.ignorecase = true
vim.o.smartcase = true

-- ///////////////////////////////////////////////////////////
-- Disable mouse entirely
-- ///////////////////////////////////////////////////////////
vim.keymap.set("n", "<up>", "<nop>", { noremap = true })
vim.keymap.set("n", "<down>", "<nop>", { noremap = true })
vim.keymap.set("i", "<up>", "<nop>", { noremap = true })
vim.keymap.set("i", "<down>", "<nop>", { noremap = true })
vim.opt.mouse = ""
-- ///////////////////////////////////////////////////////////

-- Numbers
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.relativenumber = true
vim.opt.ruler = false

-- Status column - NEW from 0.9
-- handled in lua/util/status_column.lua
vim.opt.statuscolumn = [[%!v:lua.require'util.status_column'.statuscolumn()]]
-- vim.opt.statuscolumn = "%=%l %s"

-- disable nvim intro
vim.opt.shortmess:append("sI")

vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 550
vim.opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
-- vim.opt.updatetime = 100
vim.opt.updatetime = 550

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>[]hl")

vim.g.python_recommended_style = 0
vim.g.tex_flavor = "latex"
-- vim.opt.pumheight = 15
vim.opt.linebreak = true
