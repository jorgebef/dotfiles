local M = { "mbbill/undotree" }

function M.config()
  vim.keymap.set("n", "<leader>U", "<cmd>UndotreeToggle || UndotreeFocus<CR>", {
    silent = true,
    nowait = true,
  })
end

return M
