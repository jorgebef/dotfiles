vim.g.mapleader = " "

-- REMAPS
-- ================================================================
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("v", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)
vim.keymap.set("v", "k", "gk", opts)

-- " =========================== FUNCTIONAL REMAPS =============================
vim.keymap.set("v", "p", '"_dP', opts)

-- remap("n", "'", "`", ns_opts)
-- remap("n", "'", ":WhichKey '", ns_opts)

-- indenting and staying in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

vim.keymap.set("n", "<esc>", ':noh<cr>:echo""<esc>', opts)

-- improved scrolling
vim.keymap.set("n", "<C-e>", "6<C-e>", opts)
vim.keymap.set("n", "<C-y>", "6<C-y>", opts)
vim.keymap.set("c", "<C-e>", "6<C-e>", opts)
vim.keymap.set("c", "<C-y>", "6<C-y>", opts)
vim.keymap.set("x", "<C-e>", "6<C-e>", opts)
vim.keymap.set("x", "<C-y>", "6<C-y>", opts)
vim.keymap.set("v", "<C-e>", "6<C-e>", opts)
vim.keymap.set("v", "<C-y>", "6<C-y>", opts)

-- improved split navigation
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)

vim.keymap.set("n", "<leader>w", ":silent write<cr>", opts)
vim.keymap.set("n", "<leader>q", ":q<cr>", opts)
vim.keymap.set("n", "<leader>Q", ":qa<cr>", opts)

vim.keymap.set("n", "<leader>p", '"+p', opts)
vim.keymap.set("v", "<leader>p", '"+p', opts)
vim.keymap.set("n", "<leader>y", '"+y', opts)
vim.keymap.set("v", "<leader>y", '"+y', opts)

vim.keymap.set("n", "<leader>3", [["syiw<Esc>:let @/ = @s | set hls<CR>]], opts)
vim.keymap.set("v", "<leader>3", [["sy<Esc>:let @/ = @s | set hls<CR>]], opts)

-- SEARCH AND REPLACE
vim.keymap.set("n", "<leader>R", ":.,$s/<C-r><C-w>//gc<Left><Left><Left>", { noremap = true, nowait = true })
vim.keymap.set("v", "<leader>R", '"hy:.,$s/<C-r>h//gc<Left><Left><Left>', { noremap = true, nowait = true })

-- Make new line above or below without entering insert mode
vim.keymap.set("n", "<leader>o", 'o<esc>0"_D<esc>', opts)
vim.keymap.set("n", "<leader>O", 'O<esc>0"_D<esc>', opts)

-- buffer navigation
vim.keymap.set("n", "<leader>bn", ":bn<cr>", opts)
vim.keymap.set("n", "<leader>bp", ":bp<cr>", opts)

vim.keymap.set("n", "<leader>bC", function()
	vim.cmd([[
function! DeleteHiddenBuffers()
let tpbl=[]
let closed = 0
call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
if getbufvar(buf, '&mod') == 0
silent execute 'bwipeout' buf
let closed += 1
endif
endfor
echo "Closed ".closed." hidden buffers"
endfunction
  DeleteHiddenBuffers()
]])
end, opts)

-- improved split manipulation
vim.keymap.set("n", "<leader>mj", "<C-w>J", opts)
vim.keymap.set("n", "<leader>mk", "<C-w>K", opts)
vim.keymap.set("n", "<leader>ml", "<C-w>L", opts)
vim.keymap.set("n", "<leader>mh", "<C-w>H", opts)

vim.keymap.set("n", "<leader>=", "<C-w>=", opts)
vim.keymap.set("n", "<leader>+", "<C-w>8>", opts)
vim.keymap.set("n", "<leader>-", "<C-w>8<", opts)

-- remap("n", "<leader>s", "/", ns_opts)

vim.keymap.set("n", "<leader>sv", ":vs<CR>", opts)
vim.keymap.set("n", "<leader>sh", ":split<CR>", opts)

local function reload_nvim_conf()
	for name, _ in pairs(package.loaded) do
		if name:match("^core") or name:match("^lsp") or name:match("^plugins") then
			package.loaded[name] = nil
		end
	end
	dofile(vim.env.MYVIMRC)
	vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>cR", function()
	reload_nvim_conf()
end, opts)
