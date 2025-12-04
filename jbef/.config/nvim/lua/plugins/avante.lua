return {
  "yetone/avante.nvim",
  -- enabled = false,
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "folke/snacks.nvim", -- for file_selector provider snacks
    "stevearc/dressing.nvim", -- for input provider dressing
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    provider = "gemini", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
    -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
    -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
    -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
    -- auto_suggestions_provider = "copilot",
    providers = {
      ---@type AvanteSupportedProvider
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        -- model = "gemini-2.0-flash",
        model = "gemini-2.0-pro-exp-02-05",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          generationConfig = {
            temperature = 0.75,
          },
        },
      },
    },
    windows = {
      position = "right", -- the position of the sidebar
      wrap = true, -- similar to vim.o.wrap
      width = 20, -- default % based on available width
      ask = {
        floating = false, -- Open the 'AvanteAsk' prompt in a floating window
        start_insert = false, -- Start insert mode when opening the ask window
      },
      -- mappings = {
      --   accept = "<C-i>",
      -- },
    },
  },

  keys = {
    -- {
    --   "<C-t>",
    --   function()
    --     -- require("avante").toggle_sidebar({ floating = true })
    --     require("avante").toggle_sidebar()
    --   end,
    -- },
    -- {
    --   "<leader>at",
    --   function()
    --     require("avante").toggle_sidebar({ floating = true })
    --     -- vim.cmd.normal({ "<C-w>=", bang = true })
    --   end,
    -- },
  },
}
