return {
  "dmtrKovalenko/fff.nvim",
  build = "cargo build --release",
  enabled = false,
  opts = {
    -- pass here all the options
  },
  keys = {
    {
      "<leader>ff", -- try it if you didn't it is a banger keybinding for a picker
      function()
        require("fff").find_in_git_root() -- Find files in the current git repository
      end,
      desc = "Toggle FFF",
    },
  },
}
