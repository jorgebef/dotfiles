-- place this in one of your configuration file(s)
local hop = require("hop")
local directions = require("hop.hint").HintDirection

hop.setup({ keys = "etovxqpdygfblzhckisuranETOVXQPDYGFBLZHCKISURAN" })

vim.keymap.set("", "s", "<cmd>HopPattern<CR>", { silent = true })
-- vim.keymap.set("", "s", "<cmd>HopChar2<CR>", { silent = true })

-- vim.keymap.set("", "f", function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, { remap = true })
-- vim.keymap.set("", "F", function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR })
-- end, { remap = true })
-- vim.keymap.set("", "t", function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
-- end, { remap = true })
-- vim.keymap.set("", "T", function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
-- end, { remap = true })
