local M = { "echasnovski/mini.nvim" } -- Several small plugins in one

function M.config()
  --#####################################################
  require("mini.bufremove").setup({})
  vim.keymap.set("n", "<leader>bd", function()
    -- Default values are 0 for current buffer and false for force
    -- https://github.com/echasnovski/mini.bufremove/blob/main/doc/mini-bufremove.txt
    -- See :h mini.bufremove
    require("mini.bufremove").delete(0, false)
  end, { silent = true, nowait = true })
  --#####################################################

  --#####################################################
  require("mini.pairs").setup({})
  --#####################################################

  --#####################################################
  -- require("mini.notify").setup({})
  --#####################################################

  --#####################################################
  require("mini.ai").setup({})
  --#####################################################

  --#####################################################
  require("mini.indentscope").setup({
    draw = {
      -- Delay (in ms) between event and start of drawing scope indicator
      delay = 0,

      -- Animation rule for scope's first drawing. A function which, given
      -- next and total step numbers, returns wait time (in ms). See
      -- |MiniIndentscope.gen_animation| for builtin options. To disable
      -- animation, use `require('mini.indentscope').gen_animation.none()`.
      -- animation = --<function: implements constant 20ms between steps>,
      animation = require("mini.indentscope").gen_animation.none(),

      -- Symbol priority. Increase to display on top of more symbols.
      priority = 2,
    },
    symbol = "│",
  })

  -- vim.api.nvim_create_augroup("MiniIndentscope", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "NvimTree" },
    group = "MiniIndentscope",
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })
  --#####################################################
end

return M
