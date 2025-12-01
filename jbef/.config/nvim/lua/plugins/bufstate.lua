return {
  "syntaxpresso/bufstate.nvim",
  dependencies = { "folke/snacks.nvim" },
  enabled = false,
  opts = {
    filter_by_tab = true, -- Enable tab-based buffer filtering
    autoload_last_session = false, -- Auto-load latest session on startup
    autosave = {
      enabled = true, -- Enable autosave
      on_exit = true, -- Save on exit
      interval = 300000, -- Auto-save every 5 minutes
      debounce = 30000, -- Min 30s between saves
    },
  },
}
