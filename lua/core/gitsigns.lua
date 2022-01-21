-- gitsigns.nvim
require("gitsigns").setup({
	signs = {
		delete = {
			text = "▶",
		},
		topdelete = {
			text = "▶",
		},
	},
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = false,
		virt_text_pos = "eol",
		delay = 500,
		ignore_whitespace = false,
	},
})
Keymap("n", "<leader>gs", ":Gitsigns preview_hunk<CR>")
Keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>")
