local M = {
  "hrsh7th/nvim-cmp",
  branch = "main",
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
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

  vim.o.completeopt = "menu,menuone,noselect"

  cmp.setup({
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      completion = {
        -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        border = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" },
        winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        col_offset = -3,
        side_padding = 0,
      },
      documentation = {
        -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        border = { "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌" },
        -- winhighlight = "Normal:NormalFloat,NormalNC:NormalFloat,FloatBorder:FloatBorder",
        winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        side_padding = 4,
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
    sources = cmp.config.sources({
      { name = "nvim_lsp", max_item_count = 10 },
      { name = "path", max_item_count = 10 },
      { name = "luasnip", keyword_length = 4, max_item_count = 6 }, -- For luasnip users.
    }, {
      { name = "buffer", keyword_length = 4, max_item_count = 6 },
    }),
    performance = {
      debounce = 0,
      throttle = 0,
      fetching_timeout = 150,
    },
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
        return kind
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

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
    }, {
      { name = "buffer" },
    }),
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline({}),
    sources = {
      { name = "cmdline" },
      { name = "cmdline_history" },
      { name = "path" },
    },
  })
end

return M
