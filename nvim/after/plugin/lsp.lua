local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local ui = require("jbef.ui")
local navic = require("nvim-navic")
local cmp = require("cmp_nvim_lsp")
local util = require("jbef.util")
-- local util = require("util")

mason.setup()

local servers = {
	"tsserver",
	"tailwindcss",
	"astro",
	"sumneko_lua",
	"rust_analyzer",
	"pyright",
	"bashls",
}

mason_lspconfig.setup({
	ensure_installed = servers,
})

local signs = {
	Error = ui.diagnostics.Error,
	Warning = ui.diagnostics.Warning,
	Hint = ui.diagnostics.Hint,
	Information = ui.diagnostics.Information,
}

for type, icon in pairs(signs) do
	-- local hl = "LspDiagnosticsSign" .. type
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- local border = {
-- 	{ "╭", "FloatBorder" },
-- 	{ "─", "FloatBorder" },
-- 	{ "╮", "FloatBorder" },
-- 	{ "│", "FloatBorder" },
-- 	{ "╯", "FloatBorder" },
-- 	{ "─", "FloatBorder" },
-- 	{ "╰", "FloatBorder" },
-- 	{ "│", "FloatBorder" },
-- }

-- Do not forget to use the on_attach function
-- require 'lspconfig'.myserver.setup { handlers=handlers }
-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
local function improved_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or ui.border.Single
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.lsp.util.open_floating_preview = improved_floating_preview

-- LSP settings (for overriding per client)
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = ui.border.Single }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = ui.border.Single }),
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
	if client.name == "tailwindcss" then
	else
		navic.attach(client, bufnr)
	end

	local remap_opts = { noremap = true, silent = true }

	vim.keymap.set("n", "<leader>lD", function()
		vim.lsp.buf.type_definition()
	end, remap_opts)

	vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", remap_opts)

	-- Jump to diagnostics
	vim.keymap.set("n", "]w", function()
		vim.diagnostic.goto_next({ severity = { max = "WARN" }, float = true })
	end, remap_opts)
	vim.keymap.set("n", "]e", function()
		vim.diagnostic.goto_next({ severity = "ERROR", float = true })
	end, remap_opts)
	vim.keymap.set("n", "[w", function()
		vim.diagnostic.goto_prev({ severity = { max = "WARN" }, float = true })
	end, remap_opts)
	vim.keymap.set("n", "[e", function()
		vim.diagnostic.goto_prev({ severity = "ERROR", float = true })
	end, remap_opts)

	-- ============================================================
	-- USING NULL-LS
	-- vim.keymap.set("n", "<leader>lf", ":LspFormat<CR>", ns_opts)

	vim.keymap.set("n", "<leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end, remap_opts)

	vim.keymap.set("n", "<leader>ld", function()
		vim.lsp.buf.definition()
	end, remap_opts)

	vim.keymap.set("n", "<leader>lr", function()
		vim.lsp.buf.rename()
	end, remap_opts)

	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover({ focusable = false })
	end, remap_opts)

	vim.keymap.set("n", "<leader>lI", function()
		vim.lsp.buf.implementation()
	end, remap_opts)

	vim.keymap.set("i", "<C-k>", function()
		vim.lsp.buf.signature_help()
	end, remap_opts)

	if client.name == "tsserver" then
		local ts_utils = require("nvim-lsp-ts-utils")
		ts_utils.setup({})
		ts_utils.setup_client(client)
		vim.keymap.set("n", "<leader>lo", function()
			vim.cmd.TSLspOrganize()
		end)
		vim.keymap.set("n", "<leader>lR", function()
			vim.cmd.TSLspRenameFile()
		end, remap_opts)
		vim.keymap.set("n", "<leader>li", function()
			vim.cmd.TSLspImportAll()
		end, remap_opts)
	end

	-- Function to check if a floating dialog exists and if not
	-- then check for diagnostics under the cursor
	function OpenDialogIfNoFloat()
		for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
			if vim.api.nvim_win_get_config(winid).zindex then
				return
			end
		end
		vim.diagnostic.open_float(0, {
			scope = "cursor",
			focusable = false,
			close_events = {
				"CursorMoved",
				"CursorMovedI",
				"BufHidden",
				"InsertCharPre",
				"WinLeave",
			},
		})
	end

	-- Show diagnostics under the cursor when holding position
	vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
	vim.api.nvim_create_autocmd({ "CursorHold" }, {
		pattern = "*",
		command = "lua OpenDialogIfNoFloat()",
		group = "lsp_diagnostics_hold",
	})
end

local capabilities = cmp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function extraConfig(server)
	local opts = {
		tailwindcss = {
			settings = {
				tailwindCSS = {
					classAttributes = { "class", "className", "classList", "ngClass" },
					lint = {
						cssConflict = "warning",
						invalidApply = "error",
						invalidConfigPath = "error",
						invalidScreen = "error",
						invalidTailwindDirective = "error",
						invalidVariant = "error",
						recommendedVariantOrder = "warning",
					},
					validate = true,
					experimental = {
						classRegex = {
							"clsx\\('([^)]*)'\\)",
							{ "clsx\\(([^)]*)\\)", "'([^']*)'" },
						},
					},
				},
			},
		},
	}
	return opts[server] or {}
end

-- =======================================================================
-- Loop through all the above configurations, grab each lsp server
-- and again loop through all the configs provided as an object
-- to pass them to the setup function.
-- Additionally, add to the server config any extra configuration
-- from the extraConfig function and the object it contains
-- =======================================================================
for _, server in pairs(servers) do
	local opts = util.table_merge({
		on_attach = on_attach,
		handlers = handlers,
		capabilities = capabilities,
	}, extraConfig(server))

	lspconfig[server].setup(opts)
end
