-- nvim-treesitter
require("colorizer").setup({ "*" })
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
	},
})
