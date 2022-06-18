local M = {}

M.goto_definition = function(opts)
	opts = opts or {}
	local params = vim.lsp.util.make_position_params()
	-- need to process when it have multiple result and multiple language server
	local results_lsp = vim.lsp.buf_request_sync(0, "textDocument/definition", params, opts.timeout or 10000)
	if not results_lsp or vim.tbl_isempty(results_lsp) then
		print("No results from textDocument/definition")
		return
	end
	for _, lsp_data in pairs(results_lsp) do
		if lsp_data ~= nil and lsp_data.result ~= nil and not vim.tbl_isempty(lsp_data.result) then
			for _, value in pairs(lsp_data.result) do
				local range = value.range or value.targetRange
				if range ~= nil then
					local line = range.start.line
					local character = range.start.character
					local file = value.uri or value.targetUri
					-- skip node module
					if file ~=nil and not string.match(file,'node_modules') then
					-- if file ~= nil then
						-- mark current cursor open to jumplist
						vim.api.nvim_command([[execute "normal! m` "]])
						-- my_open({ file, line + 1, character + 1 })
						vim.api.nvim_feedkeys("zz", "n", true)
						return
					end
				end
			end
		end
	end
	-- try to call default lsp function
	vim.lsp.buf.definition()
end

return M
