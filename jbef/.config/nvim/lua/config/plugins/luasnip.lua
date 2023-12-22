local M = { "saadparwaiz1/cmp_luasnip" }

function M.config()
  require("luasnip.loaders.from_vscode").lazy_load() -- You can pass { paths = "./my-snippets/"} too
  -- Load custom typescript
  require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/typescript" } })

  -- vim.keymap.set("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
  -- vim.keymap.set("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
  -- vim.keymap.set("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
  -- vim.keymap.set("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
  -- vim.keymap.set("i", "<C-E>", "<Plug>luasnip-next-choice", {})
  -- vim.keymap.set("s", "<C-E>", "<Plug>luasnip-next-choice", {})
end

return M
