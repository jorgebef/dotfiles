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
      css = { "prettierd" },
      -- Conform will run multiple formatters sequentially
      -- python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      -- xml = { "prettierd" },
      -- html = { "prettierd" },
      go = { "gofmt" },
      javascript = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      lua = { "stylua" },
      markdown = { "prettierd" },
      ["markdown.mdx"] = { "prettierd" },
      -- php = { "" },
      sh = { "shfmt" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      zsh = { "shfmt" },
    },
    formatters = {
      prettierd = {
        condition = function()
          return vim.loop.fs_realpath(".prettierrc.js") ~= nil
            or vim.loop.fs_realpath("prettier.config.mjs") ~= nil
            or vim.loop.fs_realpath(".prettierrc.mjs") ~= nil
        end,
      },
    },
  })

  vim.keymap.set("n", "<leader>lf", function()
    require("conform").format({ async = true, lsp_fallback = true }) -- managed by conform.lua
  end, util.table_merge(opts, { desc = "Conform format buffer" }))
end

return M
