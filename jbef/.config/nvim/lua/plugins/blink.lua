return {
  "saghen/blink.cmp",
  enabled = true,
  version = "*",
  -- optional: provides snippets for the snippet source
  dependencies = {
    { "xzbdmw/colorful-menu.nvim" },
    { "L3MON4D3/LuaSnip", version = "v2.*" },
  },

  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  build = "cargo build --release",
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',
  config = function()
    local ui = require("config.ui")

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
        preset = "luasnip",
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },

      completion = {
        keyword = { range = "full" },
        -- trigger = { show_on_blocked_trigger_characters = {} },
        accept = {
          auto_brackets = { enabled = false },
          create_undo_point = false,
        },
        -- trigger = { show_in_snippet = false },
        ghost_text = { enabled = true },
        list = {
          selection = {
            preselect = false,
            -- auto_insert = true,
          },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 20,
          treesitter_highlighting = true,
          window = {
            -- border = ui.border.Block
            border = ui.border.Empty,
          },
        },

        menu = {
          enabled = true,
          max_height = 10,
          -- border = ui.border.Block,
          border = ui.border.Empty,
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
          "lazydev",
          "lsp",
          "path",
          "buffer",
          "snippets",
          -- "copilot",
        },
        providers = {
          lsp = {
            opts = { tailwind_color_icon = "██" },
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
    }

    require("blink.cmp").setup(opts)
  end,
}
