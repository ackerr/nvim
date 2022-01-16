-- lualine.nvim and nvim-gps
require("nvim-gps").setup()
local gps = require("nvim-gps")
require("lualine").setup({
	options = {
		theme = "auto",
	},
	sections = {
		lualine_c = {
			{ "filename", file_status = true, path = 1 },
			{ gps.get_location, cond = gps.is_available },
		},
		lualine_x = { "encoding", "filetype" },
	},
})
