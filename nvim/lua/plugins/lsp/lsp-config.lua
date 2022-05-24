local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end
	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

local signs = {
	Error = " ",
	Warning = " ",
	Hint = " ",
	Information = " ",
}
for type, icon in pairs(signs) do
	-- local hl = "LspDiagnosticsSign" .. type
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	-- virtual_text = {
-- 	--     spacing = 1,
-- 	--     severity_limit = 'Warning',
-- 	-- },
-- 	virtual_text = false,
-- 	underline = true,
-- 	-- bold = true,
-- 	-- underline = {
-- 	--     -- THIS MAKES IT LAGGY IF THERE ARE MANY ERRORS
-- 	--     severity_limit = 'Warning',
-- 	-- },
-- 	signs = true,
-- 	float = {
-- 		source = "always",
-- 		focusable = false,
-- 	},
-- 	severity_sort = true,
-- })

local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}
-- LSP settings (for overriding per client)
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		-- virtual_text = {
		--     spacing = 1,
		--     severity_limit = 'Warning',
		-- },
		virtual_text = false,
		underline = true,
		-- bold = true,
		-- underline = {
		--     -- THIS MAKES IT LAGGY IF THERE ARE MANY ERRORS
		--     severity_limit = 'Warning',
		-- },
		signs = true,
		float = {
			source = "always",
			focusable = false,
		},
		severity_sort = true,
	}),
}
-- ================================================
--Enable (broadcasting) snippet capability for completion
-- ================================================
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Do not forget to use the on_attach function
-- require 'lspconfig'.myserver.setup { handlers=handlers }
-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- ================== Connect all servers ==========================
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
	"pyright",
	-- "tsserver",
	-- "eslint",
	"vimls",
	-- "jdtls",
	-- "jsonls",
	-- "cssls",
	-- "cssmodules_ls",
}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		handlers = handlers,
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

-- ================================================
-- REMAP FUNCTION
-- ================================================
local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

-- ================================================
-- TSSERVER
-- ================================================
nvim_lsp.tsserver.setup({
	handlers = handlers,
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup({})
		ts_utils.setup_client(client)
		-- buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
		buf_map(bufnr, "n", "<leader>rF", ":TSLspRenameFile<CR>")
		buf_map(bufnr, "n", "<leader>iA", ":TSLspImportAll<CR>")
		on_attach(client, bufnr)
	end,
})

-- -- ================================================
-- -- JAVA LANGUAGE SERVER
-- -- ================================================
require("lspconfig").jdtls.setup({ cmd = { "jdtls" } })

-- ================================================
-- RUST LANGUAGE SERVER
-- ================================================
nvim_lsp.rls.setup({
	settings = {
		rust = {
			unstable_features = false,
			build_on_save = false,
			all_features = true,
		},
	},
})

-- ================================================
-- GO LANGUAGE SERVER
-- ================================================
local util = require("lspconfig/util")
nvim_lsp.gopls.setup({
	cmd = { "gopls", "serve" },
	filetypes = { "go", "gomod" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
})

-- ================================================
-- JSON LANGUAGE SERVER
-- ================================================
nvim_lsp.jsonls.setup({
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	on_attach = on_attach,
	init_options = {
		provideFormatter = false,
	},
})

-- ================================================
-- CSS LANGUAGE SERVER
-- ================================================
nvim_lsp.cssls.setup({
	-- capabilities = capabilities,
	capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
})

--   =====================================================
--              STILL NEED TO INSTALL LuaJIT
--              LUAJIT IS UNSTABLE ON M1
--   ======================================================
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
-- ================================================
-- LUA LANGUAGE SERVER
-- ================================================
USER = vim.fn.expand("$USER")
local sumneko_root_path = ""
local sumneko_binary = ""
sumneko_root_path = "/Users/jorgebefan/.config/nvim/lua-language-server"
sumneko_binary = "/Users/jorgebefan/.config/nvim/lua-language-server/bin/macOS/lua-language-server"

nvim_lsp.sumneko_lua.setup({
	handlers = handlers,
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"nvim",
					"vim",
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
})

-- =======================================================================
-- ============================== REMAPS =================================
-- =======================================================================

local map = vim.api.nvim_set_keymap
local ns_opts = { noremap = true, silent = true }
map("n", "<leader>lD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", ns_opts)
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", ns_opts)
-- map('n', '<leader>E', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', ns_opts)
-- map("n", "<leader>E", '<cmd>lua vim.diagnostic.open_float(0, {scope="cursor"})<CR>', ns_opts)
map("n", "<leader>lw", '<cmd>lua vim.diagnostic.goto_next({severity={"HINT","WARN"},float=true})<CR>', ns_opts)
map("n", "<leader>le", '<cmd>lua vim.diagnostic.goto_next({severity="ERROR",float=true})<CR>', ns_opts)
map("n", "<leader>lW", '<cmd>lua vim.diagnostic.goto_prev({severity={"HINT","WARN"},float=true})<CR>', ns_opts)
map("n", "<leader>lE", '<cmd>lua vim.diagnostic.goto_prev({severity="ERROR",float=true})<CR>', ns_opts)
-- map("n", "<leader>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", ns_opts)
-- Formatting is handled by null-ls
map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", ns_opts)

-- See `:help vim.lsp.*` for documentation on any of the below functions
-- map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.declaration()<CR>", ns_opts)
-- Telescope does go to definition better than nvim-lsp
-- map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', ns_opts)
map("n", "<leader>ld", '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', ns_opts)
-- map('n', '<leader>ld', '<cmd>lua vim.lsp.buf.implementation()<CR>', ns_opts)
map("n", "<leader>lR", '<cmd>lua require("telescope.builtin").lsp_references()<CR>', ns_opts)
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", ns_opts)
map("n", "K", "<cmd>lua vim.lsp.buf.hover({focusable=false})<CR>", ns_opts)
map("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", ns_opts)
map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", ns_opts)

-- map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', ns_opts)
-- map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', ns_opts)
-- map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', ns_opts)

-- *************** THIS IS READY FOR NVIM 0.6 ********************************
vim.cmd(
	[[autocmd CursorHold * lua vim.diagnostic.open_float(0, {scope="cursor", focusable=false, close_events = {"CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave"}})]]
)
