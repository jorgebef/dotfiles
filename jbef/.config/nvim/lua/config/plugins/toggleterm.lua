local M = { "akinsho/toggleterm.nvim" }

M.config = function()
  require("toggleterm").setup({
    direction = "float",
    open_mapping = [[†]], -- Custom keymap set in wezterm confirm that replaces <c-\> since terminal can't produce or read the key combination
    start_in_insert = true,
    size = 20,
    float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = "curved",
    },
  })

  function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    -- vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    -- vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    -- vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
  end
  -- if you only want these mappings for toggle term use term://*toggleterm#* instead
  vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

  local Terminal = require("toggleterm.terminal").Terminal

  vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", {
    silent = true,
    nowait = true,
  })

  vim.keymap.set("n", "<leader>tn", function()
    Terminal:new():toggle()
  end, { noremap = true, silent = true })

  vim.keymap.set("n", "<leader>tg", function()
    Terminal:new({ cmd = "lazygit" }):toggle()
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
