local M = {
  "hrsh7th/nvim-cmp",
  branch = "main",
  event = "LSPAttach",
  -- WARNING
  -- DISABLE
  enabled = false,
  dependencies = {
    { "folke/lazydev.nvim", lazy = true },

    { "hrsh7th/cmp-nvim-lsp", lazy = true },
    { "hrsh7th/cmp-buffer", lazy = true },
    -- "hrsh7th/cmp-path",
    { "FelipeLema/cmp-async-path", lazy = true },

    -- { "hrsh7th/cmp-cmdline" },
    { "L3MON4D3/LuaSnip", lazy = true },
    { "saadparwaiz1/cmp_luasnip", lazy = true },
    { "onsails/lspkind-nvim", lazy = true },
  },
}

function M.config()
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  local types = require("cmp.types")
  local util = require("util.util")
  local ui = require("config.ui")

  lspkind.init({
    mode = "symbol_text",
    preset = "default",
    symbol_map = {
      Text = " ",
      Method = "󰆧 ",
      Function = "󰆧 ",
      Constructor = "󰆧 ",
      Field = " ",
      Variable = " ",
      Class = " ",
      Interface = " ",
      Module = "󰅩 ",
      Property = " ",
      Unit = " ",
      Value = " ",
      Enum = " ",
      Keyword = " ",
      Snippet = " ",
      Color = " ",
      File = " ",
      Reference = " ",
      Folder = " ",
      EnumMember = " ",
      Constant = "",
      Struct = " ",
      Event = " ",
      Operator = " ",
      TypeParameter = " ",
    },
  })

  -- vim.o.completeopt = "menu,menuone,noselect"

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
        -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        border = ui.border.Single,
        -- border = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" },
        winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        col_offset = -3,
        side_padding = 0,
      },
      documentation = {
        border = ui.border.Single,
        -- border = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" },
        -- winhighlight = "Normal:NormalFloat,NormalNC:NormalFloat,FloatBorder:FloatBorder",
        winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        side_padding = 4,
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

      -- ["<C-n>"] = cmp.mapping(function()
      --   if not cmp.visible() then
      --     cmp.mapping.select_next_item()
      --   else
      --     cmp.complete()
      --   end
      -- end, { "i", "s" }),

      ["<C-y>"] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
      ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- ["<Esc>"] = function(fallback)
      --   if cmp.visible() and (cmp.get_active_entry() ~= undefined) then
      --     cmp.abort()
      --   else
      --     fallback()
      --   end
      -- end,
      ["<CR>"] = function(fallback)
        if cmp.visible() and (cmp.get_active_entry() ~= undefined) then
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end,
    },
    sources = cmp.config.sources({
      -- {
      --   name = "lazydev",
      --   group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      -- },
      {
        name = "nvim_lsp",
        priority = 100,
        group_index = 1,
        -- keyword_length = 1,
      },
      -- { name = "path", keyword_length = 1 },
      { name = "async_path", priority = 30, group_index = 5 },

      { name = "luasnip", keyword_length = 1 }, -- For luasnip users.
    }, {
      { name = "buffer", keyword_length = 1 },
    }),
    performance = {
      debounce = 0,
      throttle = 0,
      fetching_timeout = 100,
      -- max_view_entries = 30,
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local doc = entry.completion_item.documentation
        if vim_item.kind == "Color" and doc then
          local content = type(doc) == "string" and doc or doc.value
          local base, _, _, _r, _g, _b = 10, content:find("rgba?%((%d+), (%d+), (%d+)")

          if not _r then
            base, _, _, _r, _g, _b = 16, content:find("#(%x%x)(%x%x)(%x%x)")
          end

          if _r then
            local r, g, b = tonumber(_r, base), tonumber(_g, base), tonumber(_b, base)
            vim_item.kind_hl_group = util.set_hl_from(r, g, b, "foreground")
          end
        end

        local kind = lspkind.cmp_format({
          mode = "symbol_text",
          with_text = true,
          maxwidth = 30,
        })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. strings[1] .. " "
        kind.menu = "    (" .. strings[2] .. ")"

        return kind
      end,
      -- format = require("lspkind").cmp_format({
      --   before = require("tailwind-tools.cmp").lspkind_format,
      -- }),
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
end

return M
