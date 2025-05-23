return {
  "brenoprata10/nvim-highlight-colors",
  enabled = true,

  config = function()
    require("nvim-highlight-colors").setup({
      ---Render style
      ---@usage 'background'|'foreground'|'virtual'
      render = "virtual",

      -- ---Set virtual symbol suffix (defaults to '')
      -- virtual_symbol_prefix = "",
      -- ---Set virtual symbol suffix (defaults to ' ')
      -- virtual_symbol_suffix = " ",

      ---Set virtual symbol position()
      ---@usage 'inline'|'eol'|'eow'
      ---inline mimics VS Code style
      ---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
      ---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
      virtual_symbol_position = "inline",

      ---Set virtual symbol (requires render to be set to 'virtual')
      virtual_symbol = "󰝤",

      ---Highlight named colors, e.g. 'green'
      enable_named_colors = false,

      ---Highlight tailwind colors, e.g. 'bg-blue-500'
      enable_tailwind = false,

      -- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
      exclude_filetypes = { "lazy", "dashboard" },
      -- exclude_buftypes = { "lazy", "dashboard" },
    })
  end,
}
