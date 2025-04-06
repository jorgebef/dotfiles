return {
  "nvimdev/lspsaga.nvim",
  enabled = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
  },

  config = function()
    require("lspsaga").setup({
      ui = {
        winbar_prefix = "",
        border = "rounded",
        devicon = true,
        foldericon = true,
        title = true,
        expand = "⊞",
        collapse = "⊟",
        code_action = "💡",
        lines = { "┗", "┣", "┃", "━", "┏" },
        kind = nil,
        button = { "", "" },
        imp_sign = "󰳛 ",
        use_nerd = true,
      },
      hover = {
        max_width = 0.9,
        max_height = 0.8,
        open_link = "gx",
        open_cmd = "!chrome",
      },
      code_action = {
        num_shortcut = true,
        show_server_name = true,
        extend_gitsigns = false,
        only_in_cursor = true,
        max_height = 0.8,
        cursorline = true,
        keys = {
          quit = "<ESC>",
          exec = "<CR>",
        },
      },
      lightbulb = {
        enable = false,
        sign = true,
        debounce = 10,
        sign_priority = 40,
        virtual_text = true,
        enable_in_insert = true,
        ignore = {
          clients = {},
          ft = {},
        },
      },
      request_timeout = 2000,
      rename = {
        in_select = false,
        auto_save = false,
        project_max_width = 0.5,
        project_max_height = 0.5,
        keys = {
          quit = "<C-k>",
          exec = "<CR>",
          select = "x",
        },
      },
      implement = {
        enable = false,
        sign = true,
        lang = {},
        virtual_text = true,
        priority = 100,
      },
      beacon = {
        enable = true,
        frequency = 7,
      },
      floaterm = {
        height = 0.7,
        width = 0.7,
      },
    })
  end,

  keys = {
    {
      "<leader>la",
      function()
        vim.cmd([[Lspsaga code_action]])
      end,
      desc = "Lspsaga code actions",
    },
    -- {
    --   "<leader>lr",
    --   function()
    --     vim.cmd([[Lspsaga rename]])
    --   end,
    --   desc = "Lspsaga rename",
    -- },
  },
}
