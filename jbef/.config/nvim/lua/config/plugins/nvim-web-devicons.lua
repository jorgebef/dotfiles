local M = { "nvim-tree/nvim-web-devicons" } -- Cool icons

function M.config()
  local devicons = require("nvim-web-devicons")

  devicons.set_icon({
    ["docker-compose.yml"] = {
      icon = " ",
      color = "#ED8796",
      cterm_color = "65",
      name = "dockercompose",
    },
    [".dockerignore"] = {
      icon = " ",
      color = "#cccccc",
      cterm_color = "65",
      name = "dockerignore",
    },
    ["Dockerfile"] = {
      icon = " ",
      color = "#1db7ed",
      cterm_color = "65",
      name = "Dockerfile",
    },
  })

  devicons.set_icon({
    ["robots.txt"] = {
      icon = "ﮧ",
      color = "#ff5252",
      cterm_color = "203",
      name = "Robots",
    },
  })

  devicons.set_icon({
    [".gitignore"] = {
      icon = "",
      color = "#dfdfdf",
      cterm_color = "65",
      name = "gitignore",
    },
  })

  devicons.set_icon({
    ["astro"] = {
      icon = "A",
      color = "#FF5D02",
      cterm_color = "65",
      name = "astro",
    },
  })

  devicons.set_icon({
    ["glsl"] = {
      icon = " ",
      color = "#FF9FAF",
      cterm_color = "65",
      name = "glsl",
    },
  })

  devicons.set_icon({
    ["prettier.config.js"] = {
      icon = "",
      color = "#FF9BE9",
      cterm_color = "167",
      name = "Prettier",
    },
    [".prettierrc.json"] = {
      icon = "",
      color = "#FF9BE9",
      cterm_color = "167",
      name = "Prettier",
    },
    [".prettierrc.yml"] = {
      icon = "",
      color = "#FF9BE9",
      cterm_color = "167",
      name = "Prettier",
    },
    [".prettierrc.yaml"] = {
      icon = "",
      color = "#FF9BE9",
      cterm_color = "167",
      name = "Prettier",
    },
    [".prettierrc.js"] = {
      icon = "",
      color = "#FF9BE9",
      cterm_color = "167",
      name = "Prettier",
    },
    [".prettierrc.toml"] = {
      icon = "",
      color = "#FF9BE9",
      cterm_color = "167",
      name = "Prettier",
    },
  })
end

return M
