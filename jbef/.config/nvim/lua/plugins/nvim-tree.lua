local M = {
  "nvim-tree/nvim-tree.lua",
}

function M.config()
  local nvim_tree = require("nvim-tree")
  local ui = require("config.ui")

  local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "<C-e>", "4<C-e>", opts("Up"))
    -- vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
  end

  local HEIGHT_RATIO = 0.7 -- You can change this
  local WIDTH_RATIO = 0.4 -- You can change this too

  nvim_tree.setup({
    on_attach = my_on_attach,
    disable_netrw = true,
    hijack_netrw = true,
    respect_buf_cwd = true,
    sync_root_with_cwd = true,
    view = {
      relativenumber = true,
      float = {
        enable = true,
        open_win_config = function()
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * WIDTH_RATIO
          local window_h = screen_h * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
          return {
            -- border = "rounded",
            border = ui.border.Block,
            relative = "editor",
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
      width = function()
        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
      end,
    },
    -- filters = {
    --   custom = { "^.git$" },
    -- },
    -- renderer = {
    --   indent_width = 1,
    -- },
  })

  -- ============================== REMAPS =================================
  local nsn_opts = { noremap = true, silent = true, nowait = true }
  -- vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", nsn_opts)
  vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", nsn_opts)
end

return M
