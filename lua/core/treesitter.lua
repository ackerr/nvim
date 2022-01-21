-- nvim-treesitter
require("colorizer").setup({ "*" })
require("nvim-treesitter.configs").setup({
	ensure_installed = { "go", "lua", "python", "vim" },
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = false,
	},
})
