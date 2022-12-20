-- REMAPS
-- ================================================================
local ns_opts = { noremap = true, silent = true }

vim.keymap.set("n", "j", "gj", ns_opts)
vim.keymap.set("v", "j", "gj", ns_opts)
vim.keymap.set("n", "k", "gk", ns_opts)
vim.keymap.set("v", "k", "gk", ns_opts)

-- " =========================== FUNCTIONAL REMAPS =============================
vim.keymap.set("v", "p", '"_dP', ns_opts)

-- remap("n", "'", "`", ns_opts)
-- remap("n", "'", ":WhichKey '", ns_opts)

-- indenting and staying in indent mode
vim.keymap.set("v", "<", "<gv", ns_opts)
vim.keymap.set("v", ">", ">gv", ns_opts)

vim.keymap.set("n", "<esc>", ':noh<cr>:echo""<esc>', ns_opts)

-- improved scrolling
vim.keymap.set("n", "<C-e>", "6<C-e>", ns_opts)
vim.keymap.set("n", "<C-y>", "6<C-y>", ns_opts)
vim.keymap.set("c", "<C-e>", "6<C-e>", ns_opts)
vim.keymap.set("c", "<C-y>", "6<C-y>", ns_opts)
vim.keymap.set("x", "<C-e>", "6<C-e>", ns_opts)
vim.keymap.set("x", "<C-y>", "6<C-y>", ns_opts)
vim.keymap.set("v", "<C-e>", "6<C-e>", ns_opts)
vim.keymap.set("v", "<C-y>", "6<C-y>", ns_opts)

-- improved split navigation
vim.keymap.set("n", "<C-j>", "<C-w>j", ns_opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", ns_opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", ns_opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", ns_opts)
