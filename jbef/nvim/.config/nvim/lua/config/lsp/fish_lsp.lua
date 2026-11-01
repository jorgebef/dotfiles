-- Install server with "bun install fish-lsp"
vim.lsp.config["fish_lsp"] = {
  cmd = { "fish-lsp", "start" },
  filetypes = {
    "fish",
  },
}

vim.lsp.enable("fish_lsp")
