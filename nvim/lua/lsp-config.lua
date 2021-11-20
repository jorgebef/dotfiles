local nvim_lsp = require 'lspconfig'
-- require'lspconfig'.tsserver.setup{}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local signs = {
    Error = " ",
    Warning = " ",
    Hint = " ",
    Information = " "
}
for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
      -- virtual_text = {
      --     spacing = 1,
      --     severity_limit = 'Warning',
      -- },
    virtual_text = false,
    underline = true,
    signs = true,
  }
)

local border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
}
-- LSP settings (for overriding per client)
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}
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
    'pyright',
    'tsserver',
    'vimls',
    'jsonls',
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
      handlers = handlers,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
--   =====================================================
--              STILL NEED TO INSTALL LuaJIT
--              LUAJIT IS UNSTABLE ON M1
--   ======================================================
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
USER = vim.fn.expand('$USER')
local sumneko_root_path = ""
local sumneko_binary = ""
sumneko_root_path = "/Users/jorgebefan/.config/nvim/lua-language-server"
sumneko_binary = "/Users/jorgebefan/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                    'nvim',
                    'vim',
                }
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
            }
        }
    }
}

-- =======================================================================
-- ============================== REMAPS =================================
-- =======================================================================

local map = vim.api.nvim_set_keymap
local ns_opts = { noremap = true, silent = true }
map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', ns_opts)
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', ns_opts)
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', ns_opts)
map('n', '<leader>E', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', ns_opts)
map('n', 'ge', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', ns_opts)
-- map('n', 'gw', '<cmd>lua vim.lsp.diagnostic.goto_next({,,true,Error})<CR>', ns_opts)
map('n', 'gE', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', ns_opts)
map('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', ns_opts)
map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', ns_opts)

-- See `:help vim.lsp.*` for documentation on any of the below functions
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', ns_opts)
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', ns_opts)
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', ns_opts)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', ns_opts)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', ns_opts)
-- map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', ns_opts)
-- map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', ns_opts)
-- map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', ns_opts)

-- *************** THIS IS READY FOR NVIM 0.6 ********************************
-- vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.open_float(0, {scope="cursor"})]]
