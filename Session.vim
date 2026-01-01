let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Documents/dotfiles
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 jbef/.config/tmux/tmux.conf
badd +1 jbef/.config/ghostty/config
badd +1 jbef/.config/nvim/lua/plugins/lualine.lua
badd +1 jbef/.config/nvim/lua/plugins/lsp.lua_
badd +1 jbef/.config/nvim/lua/core/lsp.lua
badd +1 jbef/.config/nvim/lua/config/lsp/typescript.lua
badd +1 jbef/.config/nvim/lua/config/lsp/lua_ls.lua
badd +1 jbef/.config/nvim/lua/plugins/neo-tree.lua
badd +1 jbef/.config/nvim/lua/plugins/blink.lua
badd +1 jbef/.config/nvim/lua/plugins/avante.lua
badd +1 jbef/.config/nvim/lua/plugins/nvim-navic.lua
badd +1 jbef/.config/nvim/lua/plugins/kanagawa.lua
badd +1 jbef/.config/nvim/lua/config/lsp/nil_ls.lua
badd +1 jbef/.config/nvim/lua/config/lsp/gopls.lua
badd +1 jbef/.config/fish/config.fish
badd +1 jbef/.config/aerospace/aerospace.toml
badd +1 jbef/.config/nvim/lua/plugins/conform.lua
badd +1 jbef/.config/nix/flake.nix
badd +1 jbef/.config/nvim/lua/plugins/snacks.lua
badd +1 jbef/.config/nvim/snippets/typescript/package.json
badd +1 jbef/.config/bin/popup-tmux
badd +1 jbef/.config/zellij/config.kdl
badd +1 jbef/.config/nvim/lua/config/lsp/jsonls.lua
badd +1 jbef/.config/nvim/lua/plugins/lspconfig.lua
badd +1 jbef/.config/nvim/lua/plugins/fzf-lua.lua_
badd +1 jbef/.config/nvim/lua/plugins/persistence-nvim.lua
badd +1 jbef/.config/nvim/lua/plugins/flash-nvim.lua
badd +1 jbef/.config/nvim/lua/plugins/fff-nvim.lua
badd +1 jbef/.config/nvim/init.lua
badd +1 jbef/.config/wezterm/user/catppuccin.lua
badd +1 jbef/qmk_firmware/keyboards/crkbd/keymaps/jbef/rules.mk
badd +1 jbef/qmk_firmware/keyboards/crkbd/keymaps/jbef/keymap.c
badd +1 jbef/qmk_firmware/keyboards/crkbd/keymaps/jbef/config.h
badd +1 jbef/qmk_firmware/keyboards/crkbd/keymaps/jbef/smtd.h
badd +1 jbef/.config/nvim/lua/plugins/typescript-tools.lua
badd +1 jbef/.config/nvim/lua/plugins/treesitter.lua
badd +1 jbef/.config/nvim/lua/config/lsp/tailwindcss.lua
badd +1 jbef/.config/fish/functions/fish_prompt.fish
badd +1 jbef/.config/starship.toml
badd +1 jbef/.config/fish/conf.d/fnm.fish
badd +1 jbef/.config/nvim/lua/plugins/mini.lua
badd +6 jbef/.config/nvim/lua/plugins/bufstate.lua
badd +1 jbef/.config/nvim/lua/core/lazy.lua
badd +1 jbef/.config/nvim/lua/plugins/noice.lua
badd +1 jbef/.config/nvim/lua/util/util.lua
badd +1 jbef/.config/nvim/lua/utils.lua
argglobal
%argdel
set lines=72 columns=316
edit jbef/.config/nvim/lua/plugins/bufstate.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
wincmd =
tcd ~/Documents/dotfiles
argglobal
setremote foldmethod=manual
setremote foldexpr=v:lua.vim.treesitter.foldexpr()
setremote foldmarker={{{,}}}
setremote foldignore=#
setremote foldlevel=0
setremote foldminlines=1
setremote foldnestmax=20
setremote foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 6 - ((5 * winheight(0) + 35) / 70)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 6
normal! 032|
wincmd w
argglobal
if bufexists(fnamemodify("~/Documents/dotfiles/jbef/.config/tmux/tmux.conf", ":p")) | buffer ~/Documents/dotfiles/jbef/.config/tmux/tmux.conf | else | edit ~/Documents/dotfiles/jbef/.config/tmux/tmux.conf | endif
if &buftype ==# 'terminal'
  silent file ~/Documents/dotfiles/jbef/.config/tmux/tmux.conf
endif
balt ~/Documents/dotfiles/jbef/.config/nvim/lua/plugins/bufstate.lua
setremote foldmethod=manual
setremote foldexpr=0
setremote foldmarker={{{,}}}
setremote foldignore=#
setremote foldlevel=0
setremote foldminlines=1
setremote foldnestmax=20
setremote foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 35) / 70)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
2wincmd w
wincmd =
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
