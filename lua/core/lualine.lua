-- lualine.nvim and nvim-gps
-- require("nvim-gps").setup()
-- local gps = require("nvim-gps")
require("lualine").setup({
	options = {
		theme = "auto",
	},
	sections = {
		lualine_a = { "mode" },
		-- lualine_b = { "branch", "diff", "diagnostics" },
		lualine_b = { "branch" },
		lualine_c = {
			{ "filename", file_status = true, path = 1 },
			-- { gps.get_location, cond = gps.is_available },
		},
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	extensions = { "toggleterm" },
})
