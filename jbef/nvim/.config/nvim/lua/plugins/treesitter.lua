---@module "lazy"
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  dependencies = {
    -- {
    --   "nvim-treesitter/nvim-treesitter-context",
    -- },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
    },
    -- {
    --   "nvim-treesitter/nvim-treesitter-context",
    --   opts = {
    --     -- Avoid the sticky context from growing a lot.
    --     max_lines = 3,
    --     -- Match the context lines to the source code.
    --     multiline_threshold = 1,
    --     -- Disable it when the window is too small.
    --     min_window_height = 20,
    --   },
    --   keys = {
    --     {
    --       "[c",
    --       function()
    --         -- Jump to previous change when in diffview.
    --         if vim.wo.diff then
    --           return "[c"
    --         else
    --           vim.schedule(function()
    --             require("treesitter-context").go_to_context()
    --           end)
    --           return "<Ignore>"
    --         end
    --       end,
    --       desc = "Jump to upper context",
    --       expr = true,
    --     },
    --   },
    -- },
    -- "nvim-treesitter/playground",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local languages = {
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
      "typescriptreact",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    }

    local ts = require("nvim-treesitter")

    ts.install()

    local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

    local ignore_filetypes = {
      "blink-cmp-menu",
      "checkhealth",
      "lazy",
      "mason",
      "noice",
      "snacks_dashboard",
      "snacks_picker_input",
      "snacks_picker_list",
      "snacks_picker_preview",
      "snacks_notif",
      "snacks_win",
    }

    -- vim.g.skip_ts_context_commentstring_module = true
    -- require("ts_context_commentstring").setup({
    --   enable_autocmd = false,
    -- })

    -- -- MDX
    -- vim.filetype.add({
    --   extension = {
    --     mdx = "mdx",
    --   },
    -- })
    -- vim.treesitter.language.register("markdown", "mdx")

    -- Auto-install parsers and enable highlighting on FileType
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = languages,
      desc = "Enable treesitter highlighting and indentation",
      callback = function(event)
        -- if vim.tbl_contains(ignore_filetypes, event.match) then
        --   return
        -- end

        local lang = vim.treesitter.language.get_lang(event.match) or event.match
        local buf = event.buf

        -- Start highlighting immediately (works if parser exists)
        pcall(vim.treesitter.start, buf, lang)

        -- Enable treesitter indentation
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- Install missing parsers (async, no-op if already installed)
        ts.install({ lang })
      end,
    })
  end,
}
