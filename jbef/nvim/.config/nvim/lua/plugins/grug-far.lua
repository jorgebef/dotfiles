-- Find and replace.
return {
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    config = function()
      require("grug-far").setup({
        transient = true,
        -- Disable folding.
        folding = { enabled = false },
        -- Don't numerate the result list.
        resultLocation = { showNumberLabel = false },
        keymaps = {
          qflist = { n = "<localleader>Q" },
          close = { n = "<localleader>q" },
          applyNext = { n = "<localleader>n" },
        },
      })
    end,
    keys = function()
      local wk = require("which-key")
      wk.add({ { "<leader>r", group = "Grug" } })
      return {
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
      }
    end,
  },
}
