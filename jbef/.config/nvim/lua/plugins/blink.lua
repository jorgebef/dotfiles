return {
  "saghen/blink.cmp",
  enabled = true,
  version = "*",
  -- optional: provides snippets for the snippet source
  dependencies = {
    "rafamadriz/friendly-snippets",
    "xzbdmw/colorful-menu.nvim",
    {
      "zbirenbaum/copilot.lua",
      opts = {
        suggestion = {
          enabled = true,
          auto_trigger = false,
          hide_during_completion = true,
          debounce = 75,
          trigger_on_accept = false,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
      },
    },
    { "L3MON4D3/LuaSnip", version = "v2.*" },
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
      },
      snippets = {
        preset = "luasnip",
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
          -- Controls if completion items will be selected automatically,
          -- and whether selection automatically inserts
          selection = {
            preselect = false,
            -- auto_insert = true,
          },
          cycle = {
            -- When `true`, calling `select_next` at the *bottom* of the completion list
            -- will select the *first* completion item.
            from_bottom = true,
            -- When `true`, calling `select_prev` at the *top* of the completion list
            -- will select the *last* completion item.
            from_top = true,
          },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 20,
          treesitter_highlighting = true,
        },

        menu = {
          enabled = true,
          -- min_width = 35,
          max_height = 10,
          border = ui.border.Block,
          -- border = "none",
          -- winhighlight = "Normal:BlinkCmpMenu,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
          -- keep the cursor X lines away from the top/bottom of the window
          scrolloff = 2,
          -- which directions to show the window,
          -- falling back to the next direction when there's not enough space
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
              -- kind_icon = {
              --   highlight = function(ctx)
              --     return require("colorful-menu").blink_components_highlight(ctx)
              --   end,
              -- },

              kind_icon = {
                text = function(ctx)
                  local icon = ctx.kind_icon
                  -- if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  --   local dev_icon, _ = icons.get_icon(ctx.label)
                  --   if dev_icon then
                  --     icon = dev_icon
                  --   end
                  -- end
                  return icon .. ctx.icon_gap
                end,
                -- Optionally, use the highlight groups from nvim-web-devicons
                -- You can also add the same function for `kind.highlight` if you want to
                -- keep the highlight groups in sync with the icons.
                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  -- if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  --   local dev_icon, dev_hl = icons.get_icon(ctx.label)
                  --   if dev_icon then
                  --     hl = dev_hl
                  --   end
                  -- end
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

              -- kind = {
              --   text = function()
              --     return "kek"
              --   end,
              -- },
            },
          },
        },
      },
      cmdline = {},

      sources = {
        default = {
          "lsp",
          "path",
          "buffer",
          "snippets",
          -- "copilot",
        },
        providers = {
          lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
            -- min_keyword_length = 0,
            -- async = true,
            -- timeout_ms = 4000,
          },
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

      appearance = {
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
        kind_icons = {
          Text = "󰉿",
          Method = "󰊕",
          Function = "󰊕",
          Constructor = "󰒓",

          Field = "󰜢",
          Variable = "󰆦",
          Property = "󰖷",

          Class = "󱡠",
          Interface = "󱡠",
          Struct = "󱡠",
          Module = "󰅩",

          Unit = "󰪚",
          Value = "󰦨",
          Enum = "󰦨",
          EnumMember = "󰦨",

          Keyword = "󰻾",
          Constant = "󰏿",

          Snippet = "󱄽",
          Color = "󰏘",
          File = "󰈔",
          Reference = "󰬲",
          Folder = "󰉋",
          Event = "󱐋",
          Operator = "󰪚",
          TypeParameter = "󰬛",
        },
      },
    }

    require("blink.cmp").setup(opts)
  end,
}
