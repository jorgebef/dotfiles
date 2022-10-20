-- max_phase_one_targets = nil
-- highlight_unlabeled_phase_one_targets = false
-- max_highlighted_traversal_targets = 10
-- case_sensitive = false
-- equivalence_classes = { ' \t\r\n', }
-- substitute_chars = {}
-- safe_labels = { 's', 'f', 'n', 'u', 't', . . . }
-- labels = { 's', 'f', 'n', 'j', 'k', . . . }
-- special_keys = {
--   repeat_search = '<enter>',
--   next_phase_one_target = '<enter>',
--   next_target = {'<enter>', ';'},
--   prev_target = {'<tab>', ','},
--   next_group = '<space>',
--   prev_group = '<tab>',
--   multi_accept = '<enter>',
--   multi_revert = '<backspace>',
-- }

-- Beware that the trade-off in this mode is that you always have to
-- select a label, as there is no automatic jump to the first target (it
-- would be very confusing if the cursor would suddenly jump in the
-- opposite direction than your goal). Former vim-sneak users will know
-- how awesome a feature that is. I really suggest trying out the plugin
-- with the defaults for a while first.
-- An additional disadvantage is that operations cannot be dot-repeated
-- if the search is non-directional.

-- Now that you have carefully considered my wise advice above, I'll
-- tell you the simple trick: just initiate multi-window mode with the
-- current window as the only target.
-- require("leap").leap({ target_windows = { vim.fn.win_getid() } })

require("leap").add_default_mappings()

vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })

local remap = vim.api.nvim_set_keymap
remap(
  "n",
  "<leader>S",
  ':lua require("leap").leap({ target_windows = { vim.fn.win_getid() } })<CR>',
  { noremap = true, silent = true, nowait = true }
)
