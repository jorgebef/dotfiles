local M = { "andymass/vim-matchup" }

function M.config()
  vim.g.matchup_matchparen_offscreen = {} -- Fixes statusline flicker

  -- Disables highlighting of the text to match
  vim.api.nvim_create_augroup("matchup_matchparen_highlight", { clear = true })
  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    pattern = "*",
    command = "hi MatchParen guifg=nil gui=none",
    group = "matchup_matchparen_highlight",
  })
end

return M
