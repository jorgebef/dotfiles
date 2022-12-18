local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local icons = require("jbef.icons")
local navic = require("nvim-navic")
local cmp = require("cmp_nvim_lsp")
-- local util = require("util")

mason.setup()

local servers = {
	"tsserver",
	"tailwindcss",
	"astro",
	"sumneko_lua",
	"rust_analyzer",
	"pyright",
}

mason_lspconfig.setup({
	ensure_installed = servers,
})

local signs = {
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

-- Do not forget to use the on_attach function
-- require 'lspconfig'.myserver.setup { handlers=handlers }
-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
local function improved_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.lsp.util.open_floating_preview = improved_floating_preview

-- LSP settings (for overriding per client)
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
	["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
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

-- DEFAULT on_attach function
local function on_attach(client, bufnr)
	if client.name ~= "tailwindcss" then
		navic.attach(client, bufnr)
	end

	local opts = { noremap = true, silent = true }

	vim.keymap.set("n", "<leader>lD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	-- vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", ns_opts)

	-- vim.keymap.set("n", "<leader>lw", "<cmd>lua vim.diagnostic.goto_next({severity={max='WARN'},float=true})<CR>", ns_opts)
	-- vim.keymap.set("n", "<leader>le", "<cmd>lua vim.diagnostic.goto_next({severity='ERROR',float=true})<CR>", ns_opts)
	-- vim.keymap.set("n", "<leader>lW", "<cmd>lua vim.diagnostic.goto_prev({severity={max='WARN'},float=true})<CR>", ns_opts)
	-- vim.keymap.set("n", "<leader>lE", "<cmd>lua vim.diagnostic.goto_prev({severity='ERROR',float=true})<CR>", ns_opts)

	vim.keymap.set("n", "]w", "<cmd>lua vim.diagnostic.goto_next({severity={max='WARN'},float=true})<CR>", opts)
	vim.keymap.set("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity='ERROR',float=true})<CR>", opts)
	vim.keymap.set("n", "[w", "<cmd>lua vim.diagnostic.goto_prev({severity={max='WARN'},float=true})<CR>", opts)
	vim.keymap.set("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity='ERROR',float=true})<CR>", opts)

	-- ============================================================
	-- USING NULL-LS
	-- vim.keymap.set("n", "<leader>lf", ":LspFormat<CR>", ns_opts)
	vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
	-- vim.keymap.set("n", "<leader>ld", "<cmd> lua vim.lsp.buf.definition()<CR>", ns_opts)
	-- vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", ns_opts)
	-- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover({focusable=false})<CR>", ns_opts)
	vim.keymap.set("n", "<leader>lI", function()
		vim.lsp.buf.implementation()
	end, opts)
	vim.keymap.set("i", "<C-k>", function()
		vim.lsp.buf.signature_help()
	end, opts)

	if client.name == "tsserver" then
		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup({})
		ts_utils.setup_client(client)
		-- -- buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
		vim.keymap.set("n", "<leader>lR", function()
			vim.cmd.TSLspRenameFile()
		end, opts)
		vim.keymap.set("n", "<leader>li", function()
			vim.cmd.TSLspImportAll()
		end, opts)
	end
end

local capabilities = cmp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- =======================================================================
-- Loop through all the above configurations, grab each lsp server
-- and again loop through all the configs provided as an object
-- to pass them to the setup function
-- =======================================================================
for _, server in pairs(servers) do
	lspconfig[server].setup({
		on_attach = on_attach,
		handlers = handlers,
		capabilities = capabilities,
	})
end
