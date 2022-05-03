-- nvim-treesitter
require("colorizer").setup({ "*" })
require("nvim-treesitter.configs").setup({
	ensure_installed = { "go", "lua", "python", "vim", "rust" },
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = false,
	},
})

require("treesitter-context").setup({
	enable = true,
})
