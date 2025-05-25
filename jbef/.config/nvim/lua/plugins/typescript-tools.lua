return {
  "pmizio/typescript-tools.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("typescript-tools").setup({
      single_file_support = false,
      settings = {
        filetypes = {
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "mdx",
        },
        jsx_close_tag = {
          enable = true,
          filetypes = { "javascriptreact", "typescriptreact" },
        },
        separate_diagnostic_server = true,
        -- publish_diagnostic_on = "insert_leave",
        -- documentRangeFormatting = false,
        root_dir = function(...)
          return require("lspconfig.util").root_pattern(".git")(...)
        end,
      },
    })
  end,
}
