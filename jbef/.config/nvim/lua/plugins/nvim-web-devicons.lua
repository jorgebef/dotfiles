local M = { "nvim-tree/nvim-web-devicons" } -- Cool icons

function M.config()
  local devicons = require("nvim-web-devicons")

  devicons.setup({
    override_by_filename = {
      ["dockerfile.dev"] = {
        icon = "󰡨",
        color = "#448EE6",
        cterm_color = "45",
        name = "dockerfile",
      },
      ["dockerfile.prod"] = {
        icon = "󰡨",
        color = "#448EE6",
        cterm_color = "45",
        name = "dockerfile",
      },
    },
  })

  -- devicons.set_icon({
  --   ["glsl"] = {
  --     icon = " ",
  --     color = "#9F5DE2",
  --     cterm_color = "65",
  --     name = "glsl",
  --   },
  -- })

  -- devicons.set_icon({
  --   ["tailwind.config.ts"] = {
  --     icon = "󱏿",
  --     color = "#20c2e3",
  --     cterm_color = "45",
  --     name = "TailwindConfig",
  --   },
  -- })

  -- devicons.set_icon({
  --   ["Dockerfile.dev"] = {
  --     icon = "󰡨",
  --     color = "#448EE6",
  --     cterm_color = "45",
  --     name = "dockerfiledef",
  --   },
  -- })

  -- devicons.set_icon({
  --   ["prettier.config.js"] = {
  --     icon = "",
  --     color = "#FF9BE9",
  --     cterm_color = "167",
  --     name = "Prettier",
  --   },
  --   [".prettierrc.json"] = {
  --     icon = "",
  --     color = "#FF9BE9",
  --     cterm_color = "167",
  --     name = "Prettier",
  --   },
  --   [".prettierrc.yml"] = {
  --     icon = "",
  --     color = "#FF9BE9",
  --     cterm_color = "167",
  --     name = "Prettier",
  --   },
  --   [".prettierrc.yaml"] = {
  --     icon = "",
  --     color = "#FF9BE9",
  --     cterm_color = "167",
  --     name = "Prettier",
  --   },
  --   [".prettierrc.js"] = {
  --     icon = "",
  --     color = "#FF9BE9",
  --     cterm_color = "167",
  --     name = "Prettier",
  --   },
  --   [".prettierrc.toml"] = {
  --     icon = "",
  --     color = "#FF9BE9",
  --     cterm_color = "167",
  --     name = "Prettier",
  --   },
  -- })
end

return M
