local M = {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  enabled = false,

  -- local home = os.getenv("HOME")
  config = function()
    require("dashboard").setup({
      theme = "doom",
      config = {
        vertical_center = true,
        hide = {
          statusline = false, -- hide statusline default is true
          tabline = true, -- hide the tabline
          winbar = true, -- hide winbar
        },
        header = {
          " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
          " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
          " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
          " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
          " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
          " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
          "",
          "",
          "",
          "",
          "",
        }, --your header
        center = {
          {
            action = "lua require('persistence').load()",
            desc = "Restore session",
            icon = " ",
            key = "s",
            keymap = "<leader>SL",
          },
          {
            action = "Telescope find_files",
            desc = " Find file",
            icon = " ",
            key = "<leader>ff",
          },
          {
            action = "Telescope oldfiles",
            desc = " Recent files",
            icon = " ",
            key = "<leader>fr",
          },
          {
            action = ":q",
            icon = " ",
            desc = "Quit!",
            key = "q",
            keymap = "<leader>Q",
          },
        },
        footer = {}, --your footer
      },
    })
  end,
}

return M
