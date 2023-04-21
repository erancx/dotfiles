local notify = require("notify")

vim.notify = notify

notify.setup({
	background_colour = "#000000",
	render = "simple",
	stages = "fade_in_slide_out",
})
