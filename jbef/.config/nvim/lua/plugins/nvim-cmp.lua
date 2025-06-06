return {
  "hrsh7th/nvim-cmp",
  branch = "main",
  event = "LSPAttach",
  -- WARNING
  enabled = false,
  dependencies = {
    { "folke/lazydev.nvim" },

    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    -- { "FelipeLema/cmp-async-path" },

    -- { "hrsh7th/cmp-cmdline" },
    { "L3MON4D3/LuaSnip", lazy = true },
    { "saadparwaiz1/cmp_luasnip", lazy = true },
    { "onsails/lspkind-nvim" },
  },

  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local types = require("cmp.types")
    local util = require("util.util")
    local ui = require("config.ui")

    lspkind.init({
      mode = "symbol_text",
      preset = "default",
    })

    cmp.setup({
      -- enabled = function()
      --   if
      --     require("cmp.config.context").in_treesitter_capture("comment") == true
      --     or require("cmp.config.context").in_syntax_group("Comment")
      --   then
      --     return false
      --   else
      --     return true
      --   end
      -- end,
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        completion = {
          -- border = ui.border.Block,
          border = ui.border.Block,
          -- border = ui.border.Square,
          -- border = false,
          winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None",
          -- col_offset = 1,
          -- side_padding = 1,
          --
        },
        documentation = {
          -- border = ui.border.Block,
          border = ui.border.Block,
          -- border = ui.border.Square,
          -- border = false,
          winhighlight = "Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None",
          -- maxheight = 190,
        },
      },
      preselect = types.cmp.PreselectMode.None, -- :h cmp-config.preselect
      mapping = {
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.close()
          else
            cmp.complete()
          end
        end, { "i", "c" }),

        ["<C-y>"] = cmp.config.disable,
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
        ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ["<CR>"] = function(fallback)
          if cmp.visible() and (cmp.get_active_entry() ~= undefined) then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end,
      },
      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          priority = 100,
          group_index = 1,
        },
        { name = "lazydev", group_index = 0 },
        -- { name = "async_path", priority = 30, group_index = 5 },

        { name = "luasnip", keyword_length = 1 }, -- For luasnip users.
      }, {
        { name = "buffer", keyword_length = 1 },
      }),
      performance = {
        debounce = 0,
        throttle = 0,
        fetching_timeout = 100,
        -- max_view_entries = 40,
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- local doc = entry.completion_item.documentation
          -- if vim_item.kind == "Color" and doc then
          --   local content = type(doc) == "string" and doc or doc.value
          --   local base, _, _, _r, _g, _b = 10, content:find("rgba?%((%d+), (%d+), (%d+)")
          --
          --   if not _r then
          --     base, _, _, _r, _g, _b = 16, content:find("#(%x%x)(%x%x)(%x%x)")
          --   end
          --
          --   if _r then
          --     local r, g, b = tonumber(_r, base), tonumber(_g, base), tonumber(_b, base)
          --     vim_item.kind_hl_group = util.set_hl_from(r, g, b, "foreground")
          --   end
          -- end
          -- --
          -- local kind = lspkind.cmp_format({
          --   mode = "symbol_text",
          --   with_text = false,
          --   maxwidth = 30,
          -- })(entry, vim_item)
          -- local strings = vim.split(kind.kind, "%s", { trimempty = true })
          -- kind.kind = " " .. strings[1] .. " "
          -- kind.menu = "    (" .. (strings[2] or "") .. ")"
          --
          -- return kind

          -- local highlights_info = require("colorful-menu").cmp_highlights(entry)
          -- -- if highlight_info==nil, which means missing ts parser, let's fallback to use default `vim_item.abbr`.
          -- -- What this plugin offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
          -- if highlights_info ~= nil then
          --   vim_item.abbr_hl_group = highlights_info.highlights
          --   vim_item.abbr = highlights_info.text
          -- end

          vim_item = lspkind.cmp_format({
            mode = "symbol_text",
            with_text = false,
            maxwidth = 30,
          })(entry, vim_item)
          local strings = vim.split(vim_item.kind, "%s", { trimempty = true })
          vim_item.kind = " " .. strings[1] .. " "
          vim_item.menu = "    (" .. (strings[2] or "") .. ")"

          return vim_item
        end,
      },
      -- experimental = {
      --   ghost_text = true,
      -- },
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
      }, {
        { name = "buffer" },
      }),
    })
  end,
}
