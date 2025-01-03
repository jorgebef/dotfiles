local M = {
  "christoomey/vim-tmux-navigator",
  enabled = false,
}

function M.config()
  vim.cmd([[let g:tmux_navigator_no_wrap = 1]])

  local opts = { noremap = true, silent = true }
  -- improved split navigation
  vim.keymap.set("n", "<C-h>", ":<C-U>TmuxNavigateLeft<cr>", opts)
  vim.keymap.set("n", "<C-j>", ":<C-U>TmuxNavigateDown<cr>", opts)
  vim.keymap.set("n", "<C-k>", ":<C-U>TmuxNavigateUp<cr>", opts)
  vim.keymap.set("n", "<C-l>", ":<C-U>TmuxNavigateRight<cr>", opts)
end

return M
