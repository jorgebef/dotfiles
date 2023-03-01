local M = { "akinsho/toggleterm.nvim" }

M.config = function()
  require("toggleterm").setup({
    direction = "float",
    float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = "curved",
    },
  })

  local Terminal = require("toggleterm.terminal").Terminal

  vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", {
    silent = true,
    nowait = true,
  })

  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
  function _lazygit_toggle()
    lazygit:toggle()
  end
  vim.keymap.set("n", "<leader>tg", function()
    _lazygit_toggle()
  end, { noremap = true, silent = true })

  local lf = Terminal:new({ cmd = "lf", hidden = true })
  function _lf_toggle()
    lf:toggle()
  end
  vim.keymap.set("n", "<leader>tl", function()
    _lf_toggle()
  end, { noremap = true, silent = true })
end

return M
