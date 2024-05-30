local M = {}

local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  return string.match(value.targetUri, "index.d.ts") == nil
end

local filteredTypescriptDefinition = function(err, result, method, ...)
  if vim.islist(result) and #result > 1 then
    local filtered_result = filter(result, filterReactDTS)
    return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
  end
  vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
end

M.handlers = {
  -- ["textDocument/hover"] = function(_, result, ctx, config)
  --   config = config or {}
  --   config.border = "rounded"
  --   config.focusable = false
  --   config.silent = true
  --   config.focus_id = ctx.method
  --   -- if not (result or result.contents) then
  --   if result == nil then
  --     return
  --   end
  --   local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  --   markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
  --   if vim.tbl_isempty(markdown_lines) then
  --     return
  --   end
  --   return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
  -- end,

  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    focusable = false,
    trimempty = true,
    silent = true,
  }),

  ["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = require("config.ui").border.Single }
  ),

  ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    undercurl = true,
    signs = true,
    float = {
      source = "always",
      focusable = false,
    },
    severity_sort = true,
  }),

  ["textDocument/definition"] = filteredTypescriptDefinition,
}

return M
