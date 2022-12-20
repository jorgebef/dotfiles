local ns_opts = { noremap = true, silent = true }
local n_opts = { noremap = true }

vim.keymap.set("n", "<leader>w", ":silent write<cr>", ns_opts)
vim.keymap.set("n", "<leader>q", ":q<cr>", ns_opts)
vim.keymap.set("n", "<leader>Q", ":qa<cr>", ns_opts)

vim.keymap.set("n", "<leader>p", '"+p', ns_opts)
vim.keymap.set("v", "<leader>p", '"+p', ns_opts)
vim.keymap.set("n", "<leader>y", '"+y', ns_opts)
vim.keymap.set("v", "<leader>y", '"+y', ns_opts)

vim.keymap.set("n", "<leader>3", [["syiw<Esc>:let @/ = @s | set hls<CR>]], ns_opts)
vim.keymap.set("v", "<leader>3", [["sy<Esc>:let @/ = @s | set hls<CR>]], ns_opts)

-- SEARCH AND REPLACE
vim.keymap.set("n", "<leader>R", ":.,$s/<C-r><C-w>//gc<Left><Left><Left>", n_opts)
vim.keymap.set("v", "<leader>R", '"hy:.,$s/<C-r>h//gc<Left><Left><Left>', n_opts)

-- Make new line above or below without entering insert mode
vim.keymap.set("n", "<leader>o", 'o<esc>0"_D<esc>', ns_opts)
vim.keymap.set("n", "<leader>O", 'O<esc>0"_D<esc>', ns_opts)

-- buffer navigation
vim.keymap.set("n", "<leader>bn", ":bn<cr>", ns_opts)
vim.keymap.set("n", "<leader>bp", ":bp<cr>", ns_opts)

-- vim.keymap.set("n", "<leader>bC", function()
--   vim.cmd([[ 
-- function! DeleteHiddenBuffers()
-- let tpbl=[]
-- let closed = 0
-- call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
-- for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
-- if getbufvar(buf, '&mod') == 0
-- silent execute 'bwipeout' buf
-- let closed += 1
-- endif
-- endfor
-- echo "Closed ".closed." hidden buffers"
-- endfunction
--   DeleteHiddenBuffers()
-- ]] )
-- end, ns_opts)

-- improved split manipulation
vim.keymap.set("n", "<leader>mj", "<C-w>J", ns_opts)
vim.keymap.set("n", "<leader>mk", "<C-w>K", ns_opts)
vim.keymap.set("n", "<leader>ml", "<C-w>L", ns_opts)
vim.keymap.set("n", "<leader>mh", "<C-w>H", ns_opts)

vim.keymap.set("n", "<leader>=", "<C-w>=", ns_opts)
vim.keymap.set("n", "<leader>+", "<C-w>8>", ns_opts)
vim.keymap.set("n", "<leader>-", "<C-w>8<", ns_opts)

-- remap("n", "<leader>s", "/", ns_opts)

vim.keymap.set("n", "<leader>sv", ":vs<CR>", ns_opts)
vim.keymap.set("n", "<leader>sh", ":split<CR>", ns_opts)

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
end, ns_opts)
