-- TURN ALL JSON INTO JSONC
vim.api.nvim_create_augroup("jsoncComments", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "json",
  command = "set filetype=jsonc",
  group = "jsoncComments",
})

vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = "*",
  command = 'lua vim.highlight.on_yank { higroup="IncSearch", timeout=250 }',
  group = "highlight_yank",
})

vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd(
  { "VimEnter", "WinEnter", "BufRead", "BufWinEnter" },
  { pattern = "*[^{T}]", command = "setlocal cursorline", group = "CursorLine" }
)
vim.api.nvim_create_autocmd({ "WinLeave" }, { pattern = "*", command = "setlocal nocursorline", group = "CursorLine" })

-- Set global variable named typescriptDefinition for conditonal lsp keymaps
vim.api.nvim_create_augroup("TypescriptDetect", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufRead", "VimEnter", "WinEnter" }, {
  pattern = { "*" },
  callback = function()
    if vim.bo.filetype == "typescriptreact" then
      _G.isTypescriptReact = true
    else
      _G.isTypescriptReact = false
    end
  end,
  group = "TypescriptDetect",
})

vim.api.nvim_create_augroup("DockerComposeDetect", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = { "*.docker-compose.yaml", "*.docker-compose.yml" },
  callback = function()
    vim.bo.filetype = "yaml.docker-compose"
  end,
})
