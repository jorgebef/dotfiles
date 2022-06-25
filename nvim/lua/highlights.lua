local cp = require("catppuccin.core.palettes.macchiato")

-- ===============================================================================
-- UI Elements
-- ===============================================================================
vim.api.nvim_set_hl(0, "Pmenu", { bg = cp.surface0 })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = cp.text, bg = cp.surface1, bold = true })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = cp.surface0 })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = cp.blue, bg = cp.surface0 })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = cp.pink })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = cp.pink })

vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { fg = cp.pink })
vim.api.nvim_set_hl(0, "BufferlineModified", { fg = cp.red })
vim.api.nvim_set_hl(0, "BufferLineModifiedVisible", { fg = cp.red })
vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", { fg = cp.red })
vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { fg = cp.text })

vim.api.nvim_set_hl(0, "BufferLineDuplicateSelected", { fg = cp.text, bg = cp.base })
vim.api.nvim_set_hl(0, "BufferLineDuplicateVisible", { fg = cp.text, bg = cp.base })
vim.api.nvim_set_hl(0, "BufferLineDuplicate", { fg = cp.overlay2, bg = cp.base })

vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = cp.subtext0 })
vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = cp.text, bg = cp.surface0, bold = true })
vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = cp.blue })
vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = cp.blue })
vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = cp.blue })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = cp.pink })
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = cp.pink })
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = cp.red, bg = cp.surface0 })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = cp.surface2 })

vim.api.nvim_set_hl(0, "WinBar", { bg = cp.surface0 })
vim.api.nvim_set_hl(0, "WinBarNC", { bg = cp.base })
vim.api.nvim_set_hl(0, "WinBarIndicatorSelected", { fg = cp.pink, bg = cp.surface0 })
vim.api.nvim_set_hl(0, "WinbarActiveFileName", {
	fg = cp.text,
	bg = cp.surface0,
	bold = true,
	italic = true,
})
vim.api.nvim_set_hl(0, "WinbarActiveGPS", { fg = cp.overlay2, bg = cp.surface0 })
vim.api.nvim_set_hl(0, "WinbarInactiveFileName", { fg = cp.overlay2, bg = cp.base, bold = true })
vim.api.nvim_set_hl(0, "WinbarInactiveGPS", { fg = cp.surface1, bg = cp.base })
vim.api.nvim_set_hl(0, "WinBarInactiveModified", { fg = cp.red, bg = cp.surface0 })
vim.api.nvim_set_hl(0, "WinBarActiveModified", { fg = cp.red, bg = cp.base })

vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = cp.surface0 })

-- ===============================================================================
-- UI Elements
-- ===============================================================================
vim.api.nvim_set_hl(0, "tsxTSTagDelimiter", { fg = cp.maroon })
vim.api.nvim_set_hl(0, "jsxTSTagDelimiter", { fg = cp.maroon })
vim.api.nvim_set_hl(0, "javascriptTSTagDelimiter", { fg = cp.maroon })
