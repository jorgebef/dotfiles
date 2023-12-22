local M = {
  "stevearc/conform.nvim",
}

function M.config()
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      zsh = { "shfmt" },
      -- Conform will run multiple formatters sequentially
      -- python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      javascript = { { "prettierd" } },
      typescript = { { "prettierd" } },
      typescriptreact = { { "prettierd" } },
      css = { { "prettierd" } },
      json = { { "prettierd" } },
      jsonc = { { "prettierd" } },
    },
  })
end

return M
