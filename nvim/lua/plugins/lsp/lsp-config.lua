local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local icons = require("icons")

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

local signs = {
	-- Error = " ",
	-- Warning = " ",
	-- Hint = " ",
	-- Information = " ",
	Error = icons.diagnostics.Error,
	Warning = icons.diagnostics.Warning,
	Hint = icons.diagnostics.Hint,
	Information = icons.diagnostics.Information,
}
for type, icon in pairs(signs) do
	-- local hl = "LspDiagnosticsSign" .. type
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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
		virtual_text = false,
		-- virtual_text = {
		--     spacing = 1,
		--     severity_limit = 'Warning',
		-- },
		underline = true,
		-- bold = true,
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

-- -- Do not forget to use the on_attach function
-- -- require 'lspconfig'.myserver.setup { handlers=handlers }
-- -- To instead override globally
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
-- 	opts = opts or {}
-- 	opts.border = opts.border or border
-- 	return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end

-- ================================================
-- remap function for lsp server
-- ================================================
local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		silent = true,
	})
end

local servers = {
	{
		"rls",
		settings = {
			rust = {
				unstable_features = false,
				build_on_save = false,
				all_features = true,
			},
		},
	},
	{
		"dockerls",
		cmd = { "docker-langserver", "--stdio" },
		filetypes = { "dockerfile" },
		root_dir = util.root_pattern("Dockerfile"),
		single_file_support = true,
	},
	{
		"jsonls",
		cmd = { "vscode-json-language-server", "--stdio" },
		filetypes = { "json", "jsonc" },
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
		end,
		-- init_options = {
		-- 	provideFormatter = false,
		-- },
		settings = {
			json = {
				schemas = {
					{
						fileMatch = { "package.json" },
						url = "https://json.schemastore.org/package.json",
					},
					{
						fileMatch = { "tsconfig*.json" },
						url = "https://json.schemastore.org/tsconfig.json",
					},
					{
						fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
						url = "https://json.schemastore.org/prettierrc.json",
					},
					{
						fileMatch = { ".eslintrc", ".eslintrc.json" },
						url = "https://json.schemastore.org/eslintrc.json",
					},
					{
						fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
						url = "https://json.schemastore.org/babelrc.json",
					},
					{
						fileMatch = { "lerna.json" },
						url = "https://json.schemastore.org/lerna.json",
					},
					{
						fileMatch = { "now.json", "vercel.json" },
						url = "https://json.schemastore.org/now.json",
					},
					{
						fileMatch = { "ecosystem.json" },
						url = "https://json.schemastore.org/pm2-ecosystem.json",
					},
				},
			},
		},
	},
	{
		"tsserver",
		handlers = handlers,
		-- root_dir = util.root_pattern(".git"),
		on_attach = function(client, bufnr)
			-- client.server_capabilities.document_formatting = false
			-- client.server_capabilities.document_range_formatting = false
			client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
			local ts_utils = require("nvim-lsp-ts-utils")
			ts_utils.setup({})
			ts_utils.setup_client(client)
			-- buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
			buf_map(bufnr, "n", "<leader>lrf", ":TSLspRenameFile<CR>")
			buf_map(bufnr, "n", "<leader>lia", ":TSLspImportAll<CR>")

			-- =================================================
			-- CHECK THIS
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "<space>lwr", vim.lsp.buf.remove_workspace_folder, bufopts)
			vim.keymap.set("n", "<space>lwl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, bufopts)
			-- OVERRIDE WITH CUSTOM FUNCTION
			-- ONLY FOR TSSERVER
			-- vim.keymap.set("n", "<space>ld", '<cmd> lua require("utils.lsp_handlers").goto_definition()<CR>', bufopts)
			-- =================================================
		end,
	},
	{ "jdtls" },
	{
		"gopls",
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
	},
	{
		"html",
		capabilities = capabilities,
		cmd = { "vscode-html-language-server", "--stdio" },
		filetypes = { "html" },
		on_attach = on_attach,
		init_options = {
			configurationSection = { "html", "css", "javascript" },
			embeddedLanguages = {
				css = true,
				javascript = true,
			},
			provideFormatter = false,
		},
		single_file_support = true,
	},
	{
		"cssls",
		-- capabilities = capabilities,
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	},
	{
		"sumneko_lua",
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
	},
}
-- =======================================================================
-- Loop through all the above configurations, grab each lsp server
-- and again loop through all the configs provided as an object
-- to pass them to the setup function
-- =======================================================================
for _, server in pairs(servers) do
	local config = lspconfig[server[1]]

	if lspconfig.util.has_bins(config.document_config.default_config.cmd[1]) then
		local opts = {}
		-- Manually set handlers = handlers
		opts["handlers"] = handlers

		for k, v in pairs(server) do
			if type(k) ~= "number" then
				opts[k] = v
			end
		end

		config.setup(opts)
	end
end

-- =======================================================================
-- ============================== REMAPS =================================
-- =======================================================================

local map = vim.api.nvim_set_keymap
local ns_opts = { noremap = true, silent = true }
map("n", "<leader>lD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", ns_opts)
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", ns_opts)
map("n", "<leader>lw", '<cmd>lua vim.diagnostic.goto_next({severity={"HINT","WARN"},float=true})<CR>', ns_opts)
map("n", "<leader>le", '<cmd>lua vim.diagnostic.goto_next({severity="ERROR",float=true})<CR>', ns_opts)
map("n", "<leader>lW", '<cmd>lua vim.diagnostic.goto_prev({severity={"HINT","WARN"},float=true})<CR>', ns_opts)
map("n", "<leader>lE", '<cmd>lua vim.diagnostic.goto_prev({severity="ERROR",float=true})<CR>', ns_opts)
-- map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", ns_opts)
-- ============================================================
-- USING NULL-LS
map("n", "<leader>lf", ":LspFormat<CR>", ns_opts)
-- ============================================================
-- Telescope does go to definition better than nvim-lsp
-- map("n", "<leader>ld", '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', ns_opts)
-- CUSTOM GO TO DEFINITION
-- map("n", "<leader>ld", '<cmd> lua require("utils.lsp_handlers").goto_definition()<CR>', ns_opts)
map("n", "<leader>ld", "<cmd> lua vim.lsp.buf.definition()<CR>", ns_opts)
-- map("n", "<leader>ld", ":LspDef<CR>", ns_opts)
-- ============================================================
map("n", "<leader>lrr", '<cmd>lua require("telescope.builtin").lsp_references()<CR>', ns_opts)
map("n", "<leader>lrn", "<cmd>lua vim.lsp.buf.rename()<CR>", ns_opts)
map("n", "K", "<cmd>lua vim.lsp.buf.hover({focusable=false})<CR>", ns_opts)
map("n", "<leader>lii", "<cmd>lua vim.lsp.buf.implementation()<CR>", ns_opts)
map("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", ns_opts)

vim.cmd(
	[[autocmd CursorHold * lua vim.diagnostic.open_float(0, {scope="cursor", focusable=false, close_events = {"CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre", "WinLeave"}})]]
)
