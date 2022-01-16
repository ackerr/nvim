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
})
Keymap("n", "<leader>gs", ":Gitsigns preview_hunk<CR>")
Keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>")
