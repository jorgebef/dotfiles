-- local cp = require("catppuccin.palettes").get_palette()
-- local cp = require("catppuccin.palettes").get_palette("macchiato")
local cp = require("catppuccin.palettes").get_palette("mocha")

-- ===============================================================================
-- UI Elements
-- ===============================================================================
vim.api.nvim_set_hl(0, "Pmenu", { bg = cp.surface0 })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = cp.text, bg = cp.surface1, bold = true })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = cp.surface0 })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = cp.blue, bg = cp.surface0 })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = cp.pink })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = cp.pink })

-- vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { fg = cp.pink })
-- vim.api.nvim_set_hl(0, "BufferlineModified", { fg = cp.red })
-- vim.api.nvim_set_hl(0, "BufferLineModifiedVisible", { fg = cp.red })
-- vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", { fg = cp.red })
-- vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { fg = cp.text })
-- vim.api.nvim_set_hl(0, "BufferLineDuplicateSelected", { fg = cp.text, bg = cp.base })
-- vim.api.nvim_set_hl(0, "BufferLineDuplicateVisible", { fg = cp.text, bg = cp.base })
-- vim.api.nvim_set_hl(0, "BufferLineDuplicate", { fg = cp.overlay2, bg = cp.base })

vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = cp.subtext0 })
vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = cp.text, bg = cp.surface0, bold = true })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = cp.blue })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = cp.blue })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = cp.blue })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = cp.pink })
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = cp.pink })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = cp.red, bg = cp.surface0 })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = cp.surface2 })

-- local winbarActiveBg = cp.surface0
-- local winbarInactiveBg = cp.base
vim.api.nvim_set_hl(0, "WinBar", { bg = cp.surface0, fg = cp.text })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = cp.mantle, fg = cp.surface0 })
-- vim.api.nvim_set_hl(0, "WinBarIndicatorSelected", { fg = cp.pink, bg = winbarActiveBg })
vim.api.nvim_set_hl(0, "WinBarModActive", { fg = cp.red, bg = cp.surface0 })
vim.api.nvim_set_hl(0, "WinBarModInactive", { fg = cp.red, bg = cp.base })
vim.api.nvim_set_hl(0, "WinBarFilenameActive", { fg = cp.base, bg = cp.pink, bold = true })
vim.api.nvim_set_hl(0, "WinBarFilenameInactive", { fg = cp.surface2, bg = cp.crust, bold = true })
-- --
-- vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = cp.surface0 })

-- ===============================================================================
-- Language specific
-- ===============================================================================
-- vim.api.nvim_set_hl(0, "tsxTSTagDelimiter", { fg = cp.maroon }) -- <= version 0.8

--[[ vim.api.nvim_set_hl(0, "@tag.delimiter.tsx", { fg = cp.maroon })
vim.api.nvim_set_hl(0, "@constructor.tsx", { fg = cp.lavender })
vim.api.nvim_set_hl(0, "@include.tsx", { fg = cp.mauve, italic = true })
vim.api.nvim_set_hl(0, "@keyword.return.tsx", { fg = cp.mauve, bold = true }) ]]

-- vim.api.nvim_set_hl(0, "@tag.attribute.tsx", { fg = cp.sky })
-- vim.api.nvim_set_hl(0, "jsxTSTagDelimiter", { fg = cp.maroon })
-- vim.api.nvim_set_hl(0, "javascriptTSTagDelimiter", { fg = cp.maroon })
