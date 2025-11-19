return {
  "saghen/blink.cmp",
  enabled = true,
  version = "*",
  -- optional: provides snippets for the snippet source
  dependencies = {
    { "xzbdmw/colorful-menu.nvim" },
    -- { "Kaiser-Yang/blink-cmp-avante" },
    -- {
    --   "zbirenbaum/copilot.lua",
    --   opts = {
    --     suggestion = {
    --       enabled = true,
    --       auto_trigger = false,
    --       hide_during_completion = true,
    --       debounce = 75,
    --       trigger_on_accept = false,
    --       keymap = {
    --         accept = "<M-l>",
    --         accept_word = false,
    --         accept_line = false,
    --         next = "<M-]>",
    --         prev = "<M-[>",
    --         dismiss = "<C-]>",
    --       },
    --     },
    --   },
    -- },
    -- { "L3MON4D3/LuaSnip", version = "v2.*" },
    { "rafamadriz/friendly-snippets" },
  },

  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  build = "cargo build --release",
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',
  config = function()
    local ui = require("config.ui")
    local icons = require("mini.icons")

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    local opts = {
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "hide" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next" },
        ["<S-Tab>"] = { "select_prev" },
        ["<C-d>"] = { "scroll_documentation_down" },
        ["<C-u>"] = { "scroll_documentation_up" },
      },

      snippets = {
        opts = {
          friendly_snippets = true,
        },
        -- preset = "luasnip",
      },

      completion = {
        -- trigger = { show_on_blocked_trigger_characters = {} },
        accept = {
          create_undo_point = false,
        },
        -- trigger = { show_in_snippet = false },
        ghost_text = { enabled = true },
        list = {
          -- Maximum number of items to display
          max_items = 100,
          selection = {
            preselect = false,
            -- auto_insert = true,
          },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 20,
          treesitter_highlighting = true,
          window = { border = ui.border.Block },
        },

        menu = {
          enabled = true,
          max_height = 10,
          border = ui.border.Block,
          scrolloff = 2,
          direction_priority = { "s", "n" },
          -- Controls whether the completion window will automatically show when typing
          auto_show = function(ctx)
            return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
          end,
          -- Controls how the completion items are rendered on the popup window
          -- 'simple' will render the item's kind icon the left alongside the label
          -- 'reversed' will render the label on the left and the kind icon + name on the right
          -- 'minimal' will render the label on the left and the kind name on the right
          -- 'function(blink.cmp.CompletionRenderContext): blink.cmp.Component[]' for custom rendering
          -- Controls how the completion items are rendered on the popup window
          draw = {
            -- align_to = "label", -- or 'none' to disable
            -- Left and right padding, optionally { left, right } for different padding on each side
            padding = 1,
            -- Gap between columns
            gap = 2,
            treesitter = { "lsp" },
            -- Components to render, grouped by column
            columns = {
              { "kind_icon" },
              { "label" },
              { "kind" },
            },

            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            components = {
              kind_icon = {
                text = function(ctx)
                  local icon = ctx.kind_icon
                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  return hl
                end,
              },

              label = {
                -- width = { min = 30, max = 30 },
                width = { min = 30, max = 30, fill = true },
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },

      cmdline = {},

      sources = {
        default = {
          -- "avante",
          "lazydev",
          "lsp",
          "path",
          "buffer",
          -- "snippets",
          -- "copilot",
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          -- avante = {
          --   module = "blink-cmp-avante",
          --   name = "Avante",
          --   opts = {
          --     -- options for blink-cmp-avante
          --   },
          -- },
          -- lsp = {
          --   name = "LSP",
          --   module = "blink.cmp.sources.lsp",
          --   min_keyword_length = 0,
          --   async = true,
          --   -- timeout_ms = 4000,
          -- },
          -- copilot = {
          --   name = "copilot",
          --   module = "blink-copilot",
          --   score_offset = 100,
          --   async = true,
          --   opts = {
          --     -- get_trigger_characters = { "@@" },
          --     max_completions = 3,
          --     max_attempts = 4,
          --     kind_name = "Copilot", ---@type string | false
          --     kind_icon = "", ---@type string | false
          --     kind_hl = "MiniIconsBlue", ---@type string | false
          --     debounce = 200, ---@type integer | false
          --     auto_refresh = {
          --       backward = true,
          --       forward = true,
          --     },
          --   },
          -- },
        },
      },
    }

    require("blink.cmp").setup(opts)
  end,
}
