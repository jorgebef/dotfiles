local M = {
  "stevearc/conform.nvim",
  event = "VeryLazy",
}

function M.config()
  local opts = { noremap = true, silent = true }
  ---@type Util
  local util = require("util.util")

  require("conform").setup({
    formatters_by_ft = {
      -- Conform will run multiple formatters sequentially
      -- python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      -- xml = { "prettierd" },
      -- html = { "prettierd" },
      css = { "oxfmt" },
      go = { "gofmt" },
      javascript = { "oxfmt" },
      json = { "oxfmt" },
      jsonc = { "oxfmt" },
      lua = { "stylua" },
      markdown = { "oxfmt" },
      ["markdown.mdx"] = { "oxfmt" },
      -- nix = { "alejandra" },
      -- php = { "" },
      sh = { "shfmt" },
      typescript = { "oxfmt" },
      typescriptreact = { "oxfmt" },
      zsh = { "shfmt" },
    },
    formatters = {
      biome = {},
      oxfmt = {
        --   command = "vp", -- use vp cli
        --   args = { "fmt", "--stdin", "$FILENAME" }, -- provide explicit flags from open buffer into --write
        --   stdin = true,
        --   -- cwd = oxfmt_root,
        --   -- require_cwd = true,
      },
      -- prettierd = {
      --   condition = function()
      --     return vim.loop.fs_realpath(".prettierrc.js") ~= nil
      --       or vim.loop.fs_realpath("prettier.config.js") ~= nil
      --       or vim.loop.fs_realpath("prettier.config.mjs") ~= nil
      --       or vim.loop.fs_realpath(".prettierrc.mjs") ~= nil
      --   end,
      -- },
    },
  })

  vim.keymap.set("n", "<leader>lf", function()
    require("conform").format({ async = true, lsp_fallback = true }) -- managed by conform.lua
  end, util.table_merge(opts, { desc = "Conform format buffer" }))
end

return M
