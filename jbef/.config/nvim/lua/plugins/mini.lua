return {
  "nvim-mini/mini.nvim",
  dependendies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
        require("ts_context_commentstring").setup({
          enable_autocmd = false,
        })
      end,
    },
  },
  enabled = true,

  config = function()
    --#####################################################

    require("mini.pairs").setup()

    require("mini.ai").setup({
      custom_textobjects = {
        -- INFO: remember to disable default behaviour in treesitter setup
        q = require("mini.ai").gen_spec.treesitter({
          a = { "@attribute.outer", "@parameter.outer" },
          i = { "@attribute.inner", "@parameter.inner" },
        }),
      },
    })

    require("mini.bufremove").setup()
    vim.keymap.set("n", "<leader>bd", function()
      require("mini.bufremove").delete(0, false)
    end, { noremap = true, nowait = true, desc = "Delete current buffer" })

    -- require("mini.diff").setup({
    --   view = {
    --     style = nil,
    --     signs = { add = "│", change = "│", delete = "│" },
    --   },
    -- })
    -- vim.keymap.set("n", "<leader>hp", function()
    --   require("mini.diff").toggle_overlay()
    -- end, { noremap = true, nowait = true, desc = "Toggle diff overlay" })

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
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = { "NvimTree", "dashboard", "undotree", "neo-tree-popup", "neo-tree", "fzf" },
      group = "MiniIndentscope",
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })

    require("mini.icons").setup({
      style = "glyph",
      -- Customize per category. See `:h MiniIcons.config` for details.
      default = {
        ["Copilot"] = { glyph = "", hl = "MiniIconsRed" },
        ["copilot"] = { glyph = "", hl = "MiniIconsRed" },
      },
      directory = {
        ["components"] = { glyph = "󱋣", hl = "MiniIconsGrey" },
      },
      extension = {},
      file = {},
      filetype = {},
      lsp = {},
      os = {},
    })
    require("mini.icons").mock_nvim_web_devicons()

    require("mini.comment").setup({
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    })

    --#####################################################
  end,
}
