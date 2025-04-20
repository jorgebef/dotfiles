local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- Text objects
    "nvim-treesitter/playground",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
}

function M.config(_, opts)
  opts = {
    -- A list of parser names, or "all"
    -- ensure_installed = "all",
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "diff",
      "fish",
      "glsl",
      "go",
      "graphql",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "php",
      "python",
      "query",
      "regex",
      "rust",
      "scss",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = {},

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
    textobjects = {
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@parameter.inner",
        },
        goto_previous_start = {
          ["[M"] = "@function.outer",
          ["[["] = "@parameter.inner",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      select = {
        enable = true,
        disable = function(lang, _buf)
          if lang == ("php" or "phpdoc") then
            return true
          else
            return false
          end
        end,
        lookahead = true,
        keymaps = {
          -- ["af"] = "@function.outer",
          -- ["if"] = "@function.inner",
          -- ["aa"] = "@attribute.outer",
          -- ["ia"] = "@attribute.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["iq"] = nil,
          ["aq"] = nil,
          -- ["iq"] = "@parameter.inner",
          -- ["aq"] = "@parameter.outer",
          -- Created in $DOTFILES_PATH/nvim/after/queries/ecma/textobjects.scm
          -- ["i`"] = "@templatestring.inner",
          -- ["a`"] = "@templatestring.outer",
        },
      },
    },

    highlight = {
      enable = true,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    playground = {
      enable = false,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
    indent = {
      enable = true,
    },
  }

  -- if type(opts.ensure_installed) == "table" then
  --   ---@type table<string, boolean>
  --   local added = {}
  --   opts.ensure_installed = vim.tbl_filter(function(lang)
  --     if added[lang] then
  --       return false
  --     end
  --     added[lang] = true
  --     return true
  --   end, opts.ensure_installed)
  -- end

  require("nvim-treesitter.configs").setup(opts)

  vim.g.skip_ts_context_commentstring_module = true
  require("ts_context_commentstring").setup({
    enable_autocmd = false,
  })

  -- -- MDX
  -- vim.filetype.add({
  --   extension = {
  --     mdx = "mdx",
  --   },
  -- })
  -- vim.treesitter.language.register("markdown", "mdx")
end

return M
