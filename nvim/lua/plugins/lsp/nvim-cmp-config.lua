-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")

require("lspkind").init({
  mode = "symbol_text",
  -- default symbol map
  -- can be either 'default' (requires nerd-fonts font) or
  -- 'codicons' for codicon preset (requires vscode-codicons font)
  --
  -- default: 'default'
  -- preset = "codicons",
  preset = "default",

  -- override preset symbols
  --
  -- default: {}
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
    -- format = lspkind.cmp_format({
    --   with_text = true,
    --   maxwidth = 50,
    -- }),
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({
        mode = "symbol_text",
        with_text = true,
        maxwidth = 70,
      })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. strings[1] .. " "
      kind.menu = "    (" .. strings[2] .. ")"
      --
      return kind
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
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

-- -- If you want insert `(` after select function or method item
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- local cmp = require('cmp')
-- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

-- -- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
-- cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline("/", {
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = {
-- 		-- { name = "buffer" },
-- 	},
-- })
