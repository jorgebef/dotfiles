local notify = require("notify")
local cp = require("catppuccin.palettes").get_palette("mocha")

notify.setup({
	background_colour = cp.base,
	fps = 30,
	icons = {
		DEBUG = "",
		ERROR = "",
		INFO = "",
		TRACE = "✎",
		WARN = "",
	},
	level = 2,
	minimum_width = 50,
	render = "default",
	stages = "fade_in_slide_out",
	timeout = 3000,
	top_down = true,
})
