local M = { "ggandor/leap.nvim" } -- Easier navigation around

function M.config()
	local leap = require("leap")

	leap.add_default_mappings()

	leap.opts.max_phase_one_targets = nil
	leap.opts.highlight_unlabeled_phase_one_targets = false
	leap.opts.max_highlighted_traversal_targets = 10
	leap.opts.case_sensitive = false
	leap.opts.equivalence_classes = { " \t\r\n" }
	leap.opts.substitute_chars = {}
	-- leap.opts.safe_labels = { 's', 'f', 'n', 'u', 't', . . . }
	-- leap.opts.labels = { 's', 'f', 'n', 'j', 'k', . . . }
	leap.opts.special_keys = {
		repeat_search = "<enter>",
		next_phase_one_target = "<enter>",
		next_target = { "<enter>", ";", "ñ" },
		prev_target = { "<tab>", ",", "," },
		next_group = "<space>",
		prev_group = "<tab>",
		multi_accept = "<enter>",
		multi_revert = "<backspace>",
	}

	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
		end,
	})
end

return M
