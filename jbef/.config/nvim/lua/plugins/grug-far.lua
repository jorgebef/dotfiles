-- Find and replace.
return {
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
      {
        "<leader>rr",
        function()
          require("grug-far").open({
            prefills = { flags = "--hidden" },
          })
        end,
        desc = "GrugFar",
        mode = { "n", "v" },
      },
      {
        "<leader>rf",
        function()
          local grug = require("grug-far")
          grug.open({ prefills = { paths = vim.fn.expand("%") } })
        end,
        desc = "GrugFar",
        mode = { "n", "v" },
      },
    },
    ---@type grug.far.OptionsOverride
    opts = {
      transient = true,
      -- Disable folding.
      folding = { enabled = false },
      -- Don't numerate the result list.
      resultLocation = { showNumberLabel = false },
    },
  },
}
