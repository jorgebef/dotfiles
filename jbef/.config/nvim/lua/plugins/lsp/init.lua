local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "SmiteshP/nvim-navic" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "pmizio/typescript-tools.nvim" },
    { "folke/lazydev.nvim" },
    {
      "mrcjkb/rustaceanvim",
      version = "^5", -- Recommended
      lazy = false, -- This plugin is already lazy
    },
    { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    { "Bilal2453/luvit-meta" }, -- optional `vim.uv` typings
  },
}

M.on_attach = require("plugins.lsp.on_attach").on_attach
M.capabilities = require("plugins.lsp.capabilities").setup
M.handlers = require("plugins.lsp.handlers").handlers

M.config = function()
  local servers = require("plugins.lsp.servers")
  local lsp = require("lspconfig")
  local ui = require("config.ui")
  local util = require("util.util")
  local manual_servers = {
    "glslls",
    "tailwindcss",
    "nushell",
    "ts_ls",
  }

  require("plugins.lsp.diagnostics").setup()

  require("mason").setup({
    ui = {
      -- border = ui.border.BlockThick,
      border = ui.border.Square,
    },
  })
  local server_names = {}
  local n = 0
  for k, _ in pairs(servers) do
    if not util.has_value(manual_servers, k) then
      n = n + 1
      server_names[n] = k
    end
  end

  require("mason-lspconfig").setup({
    ensure_installed = server_names,

    handlers = {
      function(server_name)
        local opts = vim.tbl_deep_extend("force", {
          on_attach = M.on_attach,
          capabilities = M.capabilities(),
          handlers = M.handlers,
        }, servers[server_name] or {})

        if server_name == "lua_ls" then
          require("lazydev").setup({
            library = {
              -- See the configuration section for more details
              -- Load luvit types when the `vim.uv` word is found
              { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
          })
          lsp[server_name].setup(opts)
        elseif server_name == "rust_analyzer" then
          -- -- not necesssary
          -- require("rustaceanvim").setup()
          return
        else
          lsp[server_name].setup(opts)
        end
      end,
    },
  })

  require("plugins.lsp.keymaps").common()

  lsp["nushell"].setup(vim.tbl_deep_extend("force", {
    on_attach = M.on_attach,
    capabilities = M.capabilities(),
    handlers = M.handlers,
  }, servers.nushell))

  -- INFO
  -- This is to use the insiders version of tailwindcss-language-server
  -- install via `pnpm i -g @tailwindcss/language-server@insiders`
  lsp["tailwindcss"].setup(vim.tbl_deep_extend("force", {
    on_attach = M.on_attach,
    capabilities = M.capabilities(),
    handlers = M.handlers,
  }, servers.tailwindcss))

  -- require("typescript-tools").setup({
  --   single_file_support = false,
  --   on_attach = function(client, bufnr)
  --     M.on_attach(client, bufnr)
  --   end,
  --   capabilities = M.capabilities(),
  --   handlers = M.handlers,
  --   settings = {
  --     filetypes = {
  --       "javascriptreact",
  --       "typescript",
  --       "typescriptreact",
  --       "mdx",
  --     },
  --     jsx_close_tag = {
  --       enable = true,
  --       filetypes = { "javascriptreact", "typescriptreact" },
  --     },
  --     separate_diagnostic_server = true,
  --     -- publish_diagnostic_on = "insert_leave",
  --     -- documentRangeFormatting = false,
  --     -- root_dir = function(...)
  --     --   return require("lspconfig.util").root_pattern(".git")(...)
  --     -- end,
  --   },
  -- })

  -- end
end

return M
