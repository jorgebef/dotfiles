local M = {
  "brenoprata10/nvim-highlight-colors",
}

function M.config()
  require("nvim-highlight-colors").setup({
    ---Render style
    ---@usage 'background'|'foreground'|'virtual'
    render = "virtual",

    ---Set virtual symbol (requires render to be set to 'virtual')
    virtual_symbol = "󰝤",

    ---Highlight named colors, e.g. 'green'
    enable_named_colors = false,

    ---Highlight tailwind colors, e.g. 'bg-blue-500'
    enable_tailwind = true,
  })
end

return M
