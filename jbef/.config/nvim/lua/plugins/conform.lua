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
      css = { "biome", "biome-check" },
      -- Conform will run multiple formatters sequentially
      -- python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      -- xml = { "prettierd" },
      -- html = { "prettierd" },
      go = { "gofmt" },
      javascript = { "biome", "biome-check" },
      json = { "biome", "biome-check" },
      jsonc = { "biome", "biome-check" },
      lua = { "stylua" },
      markdown = { "biome", "biome-check" },
      ["markdown.mdx"] = { "biome", "biome-check" },
      nix = { "alejandra" },
      -- php = { "" },
      sh = { "shfmt" },
      typescript = { "biome", "biome-check" },
      typescriptreact = { "biome", "biome-check" },
      zsh = { "shfmt" },
    },
    formatters = {
      biome = {},
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
