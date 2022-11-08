-- REMAPS
-- ================================================================
local nsn_opts = { noremap = true, silent = true, nowait = true }
local ns_opts = { noremap = true, silent = true }
local n_opts = { noremap = true }

vim.keymap.set("n", "j", "gj", { nowait = true, silent = true })
vim.keymap.set("v", "j", "gj", { nowait = true, silent = true })
vim.keymap.set("n", "k", "gk", { nowait = true, silent = true })
vim.keymap.set("v", "k", "gk", { nowait = true, silent = true })

vim.keymap.set("n", "ñ", ";", { nowait = true })
vim.keymap.set("n", "Ñ", ":", { nowait = true })

vim.keymap.set("", "Ñ", ":", { nowait = true })

-- " =========================== FUNCTIONAL REMAPS =============================
vim.keymap.set("n", "<leader>w", ":silent write<cr>", nsn_opts)
vim.keymap.set("n", "<leader>q", ":q<cr>", nsn_opts)
vim.keymap.set("n", "<leader>Q", ":qa<cr>", nsn_opts)

vim.keymap.set("v", "p", '"_dP', nsn_opts)

vim.keymap.set("n", "<leader>p", '"+p', nsn_opts)
vim.keymap.set("v", "<leader>p", '"+p', nsn_opts)
vim.keymap.set("n", "<leader>y", '"+y', nsn_opts)
vim.keymap.set("v", "<leader>y", '"+y', nsn_opts)

vim.keymap.set("n", "<leader>3", [["syiw<Esc>:let @/ = @s | set hls<CR>]], ns_opts)
vim.keymap.set("v", "<leader>3", [["sy<Esc>:let @/ = @s | set hls<CR>]], ns_opts)

-- SEARCH AND REPLACE
vim.keymap.set("n", "<leader>R", ":.,$s/<C-r><C-w>//gc<Left><Left><Left>", n_opts)
vim.keymap.set("v", "<leader>R", '"hy:.,$s/<C-r>h//gc<Left><Left><Left>', n_opts)

-- remap("n", "'", "`", ns_opts)
-- remap("n", "'", ":WhichKey '", ns_opts)

-- indenting and staying in indent mode
vim.keymap.set("v", "<", "<gv", ns_opts)
vim.keymap.set("v", ">", ">gv", ns_opts)
vim.keymap.set("n", "<leader>o", 'o<esc>0"_D<esc>', ns_opts)
vim.keymap.set("n", "<leader>O", 'O<esc>0"_D<esc>', ns_opts)

vim.keymap.set("n", "<esc>", ':noh<cr>:echo""<esc>', nsn_opts)

-- remap("n", "<leader>bd", ":b#|bd#<cr>", n_opts)
-- nvim_remap('n', '<leader>S', ':mksession!<cr>', { noremap = true, silent = false })
-- don't need this with vim-obsession

-- buffer navigation
vim.keymap.set("n", "<leader>n", ":bn<cr>", nsn_opts)
vim.keymap.set("n", "<leader>p", ":bp<cr>", nsn_opts)

-- improved scrolling
vim.keymap.set("n", "<C-e>", "6<C-e>", nsn_opts)
vim.keymap.set("n", "<C-y>", "6<C-y>", nsn_opts)
vim.keymap.set("c", "<C-e>", "6<C-e>", nsn_opts)
vim.keymap.set("c", "<C-y>", "6<C-y>", nsn_opts)
vim.keymap.set("x", "<C-e>", "6<C-e>", nsn_opts)
vim.keymap.set("x", "<C-y>", "6<C-y>", nsn_opts)
vim.keymap.set("v", "<C-e>", "6<C-e>", nsn_opts)
vim.keymap.set("v", "<C-y>", "6<C-y>", nsn_opts)

-- improved split navigation
vim.keymap.set("n", "<C-j>", "<C-w>j", nsn_opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", nsn_opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", nsn_opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", nsn_opts)

-- improved split manipulation
vim.keymap.set("n", "<C-S-j>", "<C-w>J", nsn_opts)
vim.keymap.set("n", "<C-S-k>", "<C-w>K", nsn_opts)
vim.keymap.set("n", "<C-S-l>", "<C-w>L", nsn_opts)
vim.keymap.set("n", "<C-S-h>", "<C-w>H", nsn_opts)

vim.keymap.set("n", "<leader>=", "<C-w>=", nsn_opts)
vim.keymap.set("n", "<leader>+", "<C-w>8>", nsn_opts)
vim.keymap.set("n", "<leader>-", "<C-w>8<", nsn_opts)

-- remap("n", "<leader>s", "/", nsn_opts)

vim.keymap.set("n", "<leader>sv", ":vs<CR>", nsn_opts)
vim.keymap.set("n", "<leader>sh", ":split<CR>", nsn_opts)

function _G.reload_nvim_conf()
  for name, _ in pairs(package.loaded) do
    if name:match("^core") or name:match("^lsp") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

vim.keymap.set("n", "<leader>cR", "<cmd>lua reload_nvim_conf()<CR>", nsn_opts)
