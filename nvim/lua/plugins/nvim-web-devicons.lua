local devicons = require("nvim-web-devicons")

devicons.set_icon({
	["docker-compose.yml"] = {
		icon = " ",
		color = "#ED8796",
		cterm_color = "65",
		name = "dockercompose",
	},
})

devicons.set_icon({
	[".dockerignore"] = {
		icon = " ",
		color = "#cccccc",
		cterm_color = "65",
		name = "dockerignore",
	},
})

devicons.set_icon({
	["Dockerfile"] = {
		icon = " ",
		color = "#1db7ed",
		cterm_color = "65",
		name = "Dockerfile",
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
