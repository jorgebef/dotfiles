local M = {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  -- WARNING
  -- DISABLE
  enabled = true,
  -- optional: provides snippets for the snippet source
  dependencies = "rafamadriz/friendly-snippets",

  -- use a release tag to download pre-built binaries
  -- version = "v0.*",
  -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
}

function M.config()
  local ui = require("config.ui")
  local blink = require("blink.cmp")

  blink.setup(
    --   {
    --   highlight = {
    --     -- sets the fallback highlight groups to nvim-cmp's highlight groups
    --     -- useful for when your theme doesn't support blink.cmp
    --     -- will be removed in a future release, assuming themes add support
    --     use_nvim_cmp_as_default = true,
    --   },
    --   fuzzy = {
    --     -- frencency tracks the most recently/frequently used items and boosts the score of the item
    --     use_frecency = true,
    --     -- proximity bonus boosts the score of items with a value in the buffer
    --     use_proximity = true,
    --     max_items = 80,
    --     -- controls which sorts to use and in which order, these three are currently the only allowed options
    --     sorts = { "label", "kind", "score" },
    --
    --     prebuiltBinaries = {
    --       -- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`
    --       -- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
    --       download = true,
    --       -- When downloading a prebuilt binary force the downloader to resolve this version. If this is uset
    --       -- then the downloader will attempt to infer the version from the checked out git tag (if any).
    --       --
    --       -- Beware that if the FFI ABI changes while tracking main then this may result in blink breaking.
    --       forceVersion = nil,
    --     },
    --   },
    --   windows = {
    --     autocomplete = {
    --       min_width = 30,
    --       max_width = 60,
    --       max_height = 10,
    --       -- border = "none",
    --       border = ui.border.Single,
    --       winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
    --       -- keep the cursor X lines away from the top/bottom of the window
    --       scrolloff = 2,
    --       -- which directions to show the window,
    --       -- falling back to the next direction when there's not enough space
    --       direction_priority = { "s", "n" },
    --       -- Controls how the completion items are rendered on the popup window
    --       -- 'simple' will render the item's kind icon the left alongside the label
    --       -- 'reversed' will render the label on the left and the kind icon + name on the right
    --       -- 'function(blink.cmp.CompletionRenderContext): blink.cmp.Component[]' for custom rendering
    --       draw = "simple",
    --       -- Controls the cycling behavior when reaching the beginning or end of the completion list.
    --       cycle = {
    --         -- When `true`, calling `select_next` at the *bottom* of the completion list will select the *first* completion item.
    --         from_bottom = true,
    --         -- When `true`, calling `select_prev` at the *top* of the completion list will select the *last* completion item.
    --         from_top = true,
    --       },
    --     },
    --     documentation = {
    --       min_width = 10,
    --       max_width = 60,
    --       max_height = 20,
    --       border = "padded",
    --       winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
    --       -- which directions to show the documentation window,
    --       -- for each of the possible autocomplete window directions,
    --       -- falling back to the next direction when there's not enough space
    --       direction_priority = {
    --         autocomplete_north = { "e", "w", "n", "s" },
    --         autocomplete_south = { "e", "w", "s", "n" },
    --       },
    --       auto_show = true,
    --       auto_show_delay_ms = 500,
    --       update_delay_ms = 100,
    --     },
    --     signature_help = {
    --       min_width = 1,
    --       max_width = 100,
    --       max_height = 10,
    --       border = ui.border.Single,
    --       winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
    --     },
    --   },
    --   -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    --   -- adjusts spacing to ensure icons are aligned
    --   nerd_font_variant = "normal",
    --
    --   -- experimental auto-brackets support
    --   -- accept = { auto_brackets = { enabled = true } }
    --
    --   -- experimental signature help support
    --   -- trigger = { signature_help = { enabled = true } }
    --
    --   keymap = {
    --     show = "<C-space>",
    --     hide = "<C-e>",
    --     accept = "<CR>",
    --     select_prev = { "<Up>", "<C-j>", "<S-Tab>", "<C-p>" },
    --     select_next = { "<Down>", "<C-k>", "<Tab>", "<C-n>" },
    --
    --     show_documentation = {},
    --     hide_documentation = {},
    --     scroll_documentation_up = "<C-d>",
    --     scroll_documentation_down = "<C-f>",
    --
    --     snippet_forward = "<Tab>",
    --     snippet_backward = "<S-Tab>",
    --   },
    --
    --   accept = {
    --     create_undo_point = true,
    --     auto_brackets = {
    --       enabled = false,
    --       default_brackets = { "(", ")" },
    --       override_brackets_for_filetypes = {},
    --       -- Overrides the default blocked filetypes
    --       force_allow_filetypes = {},
    --       blocked_filetypes = {},
    --       -- Synchronously use the kind of the item to determine if brackets should be added
    --       kind_resolution = {
    --         enabled = true,
    --         blocked_filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
    --       },
    --       -- Asynchronously use semantic token to determine if brackets should be added
    --       semantic_token_resolution = {
    --         enabled = true,
    --         blocked_filetypes = {},
    --       },
    --     },
    --   },
    --
    --   trigger = {
    --     completion = {
    --       -- regex used to get the text when fuzzy matching
    --       -- changing this may break some sources, so please report if you run into issues
    --       -- todo: shouldnt this also affect the accept command? should this also be per language?
    --       keyword_regex = "[%w_\\-]",
    --       -- LSPs can indicate when to show the completion window via trigger characters
    --       -- however, some LSPs (*cough* tsserver *cough*) return characters that would essentially
    --       -- always show the window. We block these by default
    --       blocked_trigger_characters = { " ", "\n", "\t" },
    --       -- when true, will show the completion window when the cursor comes after a trigger character when entering insert mode
    --       show_on_insert_on_trigger_character = true,
    --     },
    --
    --     signature_help = {
    --       enabled = true,
    --       blocked_trigger_characters = {},
    --       blocked_retrigger_characters = {},
    --       -- when true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
    --       show_on_insert_on_trigger_character = true,
    --     },
    --     cycle = {
    --       from_bottom = true,
    --       from_top = true,
    --     },
    --     preselect = false,
    --   },
    --
    --   kind_icons = {
    --     Text = "󰉿",
    --     Method = "󰊕",
    --     Function = "󰊕",
    --     Constructor = "󰒓",
    --
    --     Field = "󰜢",
    --     Variable = "󰆦",
    --     Property = "󰖷",
    --
    --     Class = "󱡠",
    --     Interface = "󱡠",
    --     Struct = "󱡠",
    --     Module = "󰅩",
    --
    --     Unit = "󰪚",
    --     Value = "󰦨",
    --     Enum = "󰦨",
    --     EnumMember = "󰦨",
    --
    --     Keyword = "󰻾",
    --     Constant = "󰏿",
    --
    --     Snippet = "󱄽",
    --     Color = "󰏘",
    --     File = "󰈔",
    --     Reference = "󰬲",
    --     Folder = "󰉋",
    --     Event = "󱐋",
    --     Operator = "󰪚",
    --     TypeParameter = "󰬛",
    --   },
    -- }

    {
      -- for keymap, all values may be string | string[]
      -- use an empty table to disable a keymap
      keymap = {
        show = "<C-space>",
        hide = "<C-e>",
        accept = "<CR>",
        select_prev = { "<S-Tab>", "<Up>", "<C-p>" },
        select_next = { "<Tab>", "<Down>", "<C-n>" },

        -- show_documentation = '<C-space>',
        -- hide_documentation = '<C-space>',
        show_documentation = {},
        hide_documentation = {},
        scroll_documentation_up = "<C-b>",
        scroll_documentation_down = "<C-f>",

        snippet_forward = "<Tab>",
        snippet_backward = "<S-Tab>",
      },

      accept = {
        create_undo_point = true,
        auto_brackets = {
          enabled = false,
          default_brackets = { "(", ")" },
          override_brackets_for_filetypes = {},
          -- Overrides the default blocked filetypes
          force_allow_filetypes = {},
          blocked_filetypes = {},
          -- Synchronously use the kind of the item to determine if brackets should be added
          kind_resolution = {
            enabled = true,
            blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
          },
          -- Asynchronously use semantic token to determine if brackets should be added
          semantic_token_resolution = {
            enabled = true,
            blocked_filetypes = {},
            -- How long to wait for semantic tokens to return before assuming no brackets should be added
            timeout_ms = 400,
          },
        },
      },

      trigger = {
        completion = {
          -- regex used to get the text when fuzzy matching
          -- changing this may break some sources, so please report if you run into issues
          -- todo: shouldnt this also affect the accept command? should this also be per language?
          keyword_regex = "[%w_\\-]",
          -- LSPs can indicate when to show the completion window via trigger characters
          -- however, some LSPs (*cough* tsserver *cough*) return characters that would essentially
          -- always show the window. We block these by default
          blocked_trigger_characters = { " ", "\n", "\t" },
          -- when true, will show the completion window when the cursor comes after a trigger character when entering insert mode
          show_on_insert_on_trigger_character = true,
          -- list of additional trigger characters that won't trigger the completion window when the cursor comes after a trigger character when entering insert mode
          show_on_insert_blocked_trigger_characters = { "'", '"' },
        },

        signature_help = {
          enabled = false,
          blocked_trigger_characters = {},
          blocked_retrigger_characters = {},
          -- when true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
          show_on_insert_on_trigger_character = true,
        },
      },

      fuzzy = {
        -- frencency tracks the most recently/frequently used items and boosts the score of the item
        use_frecency = true,
        -- proximity bonus boosts the score of items with a value in the buffer
        use_proximity = true,
        max_items = 200,
        -- controls which sorts to use and in which order, these three are currently the only allowed options
        sorts = { "label", "kind", "score" },

        prebuiltBinaries = {
          -- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`
          -- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
          download = true,
          -- When downloading a prebuilt binary force the downloader to resolve this version. If this is uset
          -- then the downloader will attempt to infer the version from the checked out git tag (if any).
          --
          -- Beware that if the FFI ABI changes while tracking main then this may result in blink breaking.
          forceVersion = nil,
        },
      },

      sources = {
        -- -- similar to nvim-cmp's sources, but we point directly to the source's lua module
        -- -- multiple groups can be provided, where it'll fallback to the next group if the previous
        -- -- returns no completion items
        -- -- WARN: This API will have breaking changes during the beta
        -- providers = {
        --   { "blink.cmp.sources.lsp", name = "LSP" },
        --   { "blink.cmp.sources.path", name = "Path", score_offset = 3 },
        --   { "blink.cmp.sources.snippets", score_offset = -3 },
        --   { "blink.cmp.sources.buffer", name = "Buffer", fallback_for = { "LSP" } },
        -- },
        -- FOR REF: full example
        providers = {
          -- all of these properties work on every source
          {
            "blink.cmp.sources.lsp",
            name = "LSP",
            keyword_length = 0,
            score_offset = 0,
            trigger_characters = { "", "c", "o", "o" },
          },
          -- the following two sources have additional options
          {
            "blink.cmp.sources.path",
            name = "Path",
            score_offset = 3,
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
              end,
              show_hidden_files_by_default = true,
            },
          },
          {
            "blink.cmp.sources.snippets",
            name = "Snippets",
            score_offset = -3,
            -- similar to https://github.com/garymjr/nvim-snippets
            opts = {
              friendly_snippets = true,
              search_paths = { vim.fn.stdpath("config") .. "/snippets" },
              global_snippets = { "all" },
              extended_filetypes = {},
              ignored_filetypes = {},
            },
          },
          {
            "blink.cmp.sources.buffer",
            name = "Buffer",
            fallback_for = { "LSP" },
          },
        },
      },

      windows = {
        autocomplete = {
          min_width = 15,
          max_height = 10,
          border = "none",
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
          -- keep the cursor X lines away from the top/bottom of the window
          scrolloff = 2,
          -- which directions to show the window,
          -- falling back to the next direction when there's not enough space
          direction_priority = { "s", "n" },
          -- Controls how the completion items are selected
          -- 'preselect' will automatically select the first item in the completion list
          -- 'manual' will not select any item by default
          -- 'auto_insert' will not select any item by default, and insert the completion items automatically when selecting them
          selection = "manual",
          -- Controls how the completion items are rendered on the popup window
          -- 'simple' will render the item's kind icon the left alongside the label
          -- 'reversed' will render the label on the left and the kind icon + name on the right
          -- 'minimal' will render the label on the left and the kind name on the right
          -- 'function(blink.cmp.CompletionRenderContext): blink.cmp.Component[]' for custom rendering
          draw = "simple",
          -- Controls the cycling behavior when reaching the beginning or end of the completion list.
          cycle = {
            -- When `true`, calling `select_next` at the *bottom* of the completion list will select the *first* completion item.
            from_bottom = true,
            -- When `true`, calling `select_prev` at the *top* of the completion list will select the *last* completion item.
            from_top = true,
          },
        },
        documentation = {
          min_width = 10,
          max_width = 60,
          max_height = 20,
          border = "padded",
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
          -- which directions to show the documentation window,
          -- for each of the possible autocomplete window directions,
          -- falling back to the next direction when there's not enough space
          direction_priority = {
            autocomplete_north = { "e", "w", "n", "s" },
            autocomplete_south = { "e", "w", "s", "n" },
          },
          auto_show = false,
          auto_show_delay_ms = 500,
          update_delay_ms = 50,
        },
        signature_help = {
          min_width = 1,
          max_width = 100,
          max_height = 10,
          border = "padded",
          winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
        },
      },

      highlight = {
        ns = vim.api.nvim_create_namespace("blink_cmp"),
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
      },

      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "normal",

      --   kind_icons = {
      --     Text = "󰉿",
      --     Method = "󰊕",
      --     Function = "󰊕",
      --     Constructor = "󰒓",
      --
      --     Field = "󰜢",
      --     Variable = "󰆦",
      --     Property = "󰖷",
      --
      --     Class = "󱡠",
      --     Interface = "󱡠",
      --     Struct = "󱡠",
      --     Module = "󰅩",
      --
      --     Unit = "󰪚",
      --     Value = "󰦨",
      --     Enum = "󰦨",
      --     EnumMember = "󰦨",
      --
      --     Keyword = "󰻾",
      --     Constant = "󰏿",
      --
      --     Snippet = "󱄽",
      --     Color = "󰏘",
      --     File = "󰈔",
      --     Reference = "󰬲",
      --     Folder = "󰉋",
      --     Event = "󱐋",
      --     Operator = "󰪚",
      --     TypeParameter = "󰬛",
      --   },

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
    }
  )
end

return M
