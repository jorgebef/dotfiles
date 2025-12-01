-- REMAPS
-- ================================================================
local opts = { noremap = true, silent = true }
---@type Util
local util = require("util.util")

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

-- -- vim.keymap.set("n", "<ESC>", '<ESC>:noh<CR>:lua require("notify").dismiss()<CR>', opts)
-- vim.keymap.set("n", "<ESC>", ":lua Snacks.notifier.hide()<CR>:noh<CR><ESC>", opts)

-- Poweful <esc>.
vim.keymap.set({ "i", "s", "n" }, "<esc>", function()
  if require("luasnip").expand_or_jumpable() then
    require("luasnip").unlink_current()
  end
  vim.cmd("noh")
  vim.cmd("lua Snacks.notifier.hide()")
  return "<esc>"
end, { desc = "Escape, clear hlsearch, and stop snippet session", expr = true })

-- improved scrolling
vim.keymap.set("n", "<C-e>", "4<C-e>", opts)
vim.keymap.set("n", "<C-y>", "4<C-y>", opts)
vim.keymap.set("c", "<C-e>", "4<C-e>", opts)
vim.keymap.set("c", "<C-y>", "4<C-y>", opts)
vim.keymap.set("x", "<C-e>", "4<C-e>", opts)
vim.keymap.set("x", "<C-y>", "4<C-y>", opts)
vim.keymap.set("v", "<C-e>", "4<C-e>", opts)
vim.keymap.set("v", "<C-y>", "4<C-y>", opts)

-- vim.keymap.del("n", "<M-e>")

vim.keymap.set("n", "<leader>w", ":silent write<cr>", opts)
vim.keymap.set("n", "<leader>q", ":q<cr>", opts)
vim.keymap.set("n", "<leader>Q", ":qa<cr>", opts)

-- vim.keymap.set("n", "<leader>p", '"+p', opts)
-- vim.keymap.set("v", "<leader>p", '"+p', opts)
vim.keymap.set("n", "<leader>y", '"+y', opts)
vim.keymap.set("v", "<leader>y", '"+y', opts)

vim.keymap.set("n", "<leader>3", [["syiw<Esc>:let @/ = @s | set hls<CR>]], opts)
vim.keymap.set("v", "<leader>3", [["sy<Esc>:let @/ = @s | set hls<CR>]], opts)

-- SEARCH AND REPLACE
vim.keymap.set(
  "n",
  "<leader>R",
  ":.,$s/<C-r><C-w>//gc<Left><Left><Left>",
  util.table_merge(opts, { desc = "Replace word under cursor" })
)
vim.keymap.set("v", "<leader>R", '"hy:.,$s/<C-r>h//gc<Left><Left><Left>', { noremap = true, nowait = true })

-- Make new line above or below without entering insert mode
vim.keymap.set("n", "<leader>o", 'o<esc>0"_D<esc>', opts)
vim.keymap.set("n", "<leader>O", 'O<esc>0"_D<esc>', opts)

-- buffer navigation
vim.keymap.set("n", "<leader>bn", ":bn<cr>", opts)
vim.keymap.set("n", "<leader>bp", ":bp<cr>", opts)

vim.keymap.set("n", "<leader>bC", "<cmd>WipeWindowlessBufs<cr>", { desc = "Close all buffers that aren't shown" })

-- improved split manipulation
vim.keymap.set("n", "<leader>mj", "<C-w>J", opts)
vim.keymap.set("n", "<leader>mk", "<C-w>K", opts)
vim.keymap.set("n", "<leader>ml", "<C-w>L", opts)
vim.keymap.set("n", "<leader>mh", "<C-w>H", opts)

vim.keymap.set("n", "<leader>=", "<C-w>=", opts)
-- vim.keymap.set("n", "<leader>+", "<C-w>8>", opts)
-- vim.keymap.set("n", "<leader>-", "<C-w>8<", opts)

-- remap("n", "<leader>s", "/", ns_opts)

vim.keymap.set("n", "<leader>sv", ":vs<CR>", opts)
vim.keymap.set("n", "<leader>sh", ":split<CR>", opts)

vim.keymap.set("i", "<Tab>", "", opts)
