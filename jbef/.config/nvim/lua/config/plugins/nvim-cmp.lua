local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    { "rafamadriz/friendly-snippets" },
    { "onsails/lspkind-nvim" },
  },
}

function M.config()
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  lspkind.init({
    mode = "symbol_text",
    preset = "default",
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = "",
    },
  })

  vim.o.completeopt = "menu,menuone,noselect"

  cmp.setup({
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = lspkind.cmp_format({
          mode = "symbol_text",
          with_text = true,
          maxwidth = 70,
        })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. strings[1] .. " "
        kind.menu = "    (" .. strings[2] .. ")"
        -- CHECK THIS OUT BELOW FOR TAILWIND COLOR IN CMP WINDOW
        -- if vim_item.kind == "Color" and entry.completion_item.documentation then
        --   local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
        --   if r then
        --     local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
        --     local group = "Tw_" .. color
        --     if vim.fn.hlID(group) < 1 then
        --       vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
        --     end
        --     vim_item.kind = "⬤"
        --     vim_item.kind_hl_group = group
        --     return vim_item
        --   end
        -- end
        --
        return kind
      end,
    },
    sources = cmp.config.sources({
      -- { name = "nvim_lsp", keyword_length = 2, group_index = 1, max_item_count = 20 },
      { name = "nvim_lsp" },
      -- { name = "nvim_lsp" },
      { name = "path" }, -- For vsnip users.
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = "luasnip" }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = "buffer" },
    }),
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    window = {
      completion = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        col_offset = -3,
        side_padding = 0,
      },
      documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        winhighlight = "Normal:NormalFloat,NormalNC:NormalFloat,FloatBorder:FloatBorder",
        -- maxheight = 190,
      },
    },
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
      ["<C-y>"] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
      ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<Esc>"] = function(fallback)
        if cmp.visible() and (cmp.get_active_entry() ~= undefined) then
          cmp.abort()
        else
          fallback()
        end
      end,
      ["<CR>"] = function(fallback)
        if cmp.visible() and (cmp.get_active_entry() ~= undefined) then
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end,
      -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    experimental = {
      -- native_menu = true,
    },
  })
end

return M
