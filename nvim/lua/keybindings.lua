-- REMAPS
-- ================================================================
local remap = vim.keymap.set
local nsn_opts = { noremap = true, silent = true, nowait = true }
local ns_opts = { noremap = true, silent = true }
local n_opts = { noremap = true }

remap("n", "ñ", ";", { nowait = true })
remap("n", "Ñ", ":", { nowait = true })
remap("n", "'", "`", ns_opts)

-- " =========================== FUNCTIONAL REMAPS =============================
remap("n", "<leader>w", ":silent write<cr>", nsn_opts)
remap("n", "<leader>q", ":q<cr>", nsn_opts)

remap("v", "p", '"_dP', nsn_opts)

remap("n", "<leader>y", '"+y', nsn_opts)
remap("v", "<leader>y", '"+y', nsn_opts)

remap("n", "<leader>3", [["syiw<Esc>:let @/ = @s | set hls<CR>]], ns_opts)
remap("v", "<leader>3", [["sy<Esc>:let @/ = @s | set hls<CR>]], ns_opts)

-- SEARCH AND REPLACE
remap("n", "<leader>sr", ":.,$s/<C-r><C-w>//gc<Left><Left><Left>", n_opts)
remap("v", "<leader>sr", '"hy:.,$s/<C-r>h//gc<Left><Left><Left>', n_opts)

remap("n", "'", "`", ns_opts)

-- indenting and staying in indent mode
remap("v", "<", "<gv", ns_opts)
remap("v", ">", ">gv", ns_opts)
remap("n", "<leader>o", 'o<esc>0"_D<esc>', ns_opts)
remap("n", "<leader>O", 'O<esc>0"_D<esc>', ns_opts)

remap("n", "<esc>", ':noh<cr>:echo""<esc>', nsn_opts)

-- remap("n", "<leader>bd", ":b#|bd#<cr>", n_opts)
-- nvim_remap('n', '<leader>S', ':mksession!<cr>', { noremap = true, silent = false })
-- don't need this with vim-obsession

-- improved scrolling
remap("n", "<C-e>", "4<C-e>", nsn_opts)
remap("n", "<C-y>", "4<C-y>", nsn_opts)
remap("c", "<C-e>", "4<C-e>", nsn_opts)
remap("c", "<C-y>", "4<C-y>", nsn_opts)
remap("v", "<C-e>", "4<C-e>", nsn_opts)
remap("v", "<C-y>", "4<C-y>", nsn_opts)

-- improved split navigation
remap("n", "<C-j>", "<C-w>j", nsn_opts)
remap("n", "<C-k>", "<C-w>k", nsn_opts)
remap("n", "<C-l>", "<C-w>l", nsn_opts)
remap("n", "<C-h>", "<C-w>h", nsn_opts)

-- improved split manipulation
remap("n", "<C-S-j>", "<C-w>J", nsn_opts)
remap("n", "<C-S-k>", "<C-w>K", nsn_opts)
remap("n", "<C-S-l>", "<C-w>L", nsn_opts)
remap("n", "<C-S-h>", "<C-w>H", nsn_opts)

remap("n", "<leader>=", "<C-w>=", nsn_opts)
remap("n", "<leader>+", "<C-w>8>", nsn_opts)
remap("n", "<leader>-", "<C-w>8<", nsn_opts)

remap("n", "<leader>V", ":vs<CR>", nsn_opts)

function _G.reload_nvim_conf()
	for name, _ in pairs(package.loaded) do
		if name:match("^core") or name:match("^lsp") or name:match("^plugins") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

remap("n", "<leader>cR", "<cmd>lua reload_nvim_conf()<CR>", nsn_opts)
