local M = {'mhartington/formatter.nvim' }

function M.config()
  -- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup()
end

return M
