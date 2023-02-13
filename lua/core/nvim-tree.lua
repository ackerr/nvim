-- nvim-tree.lua
require("nvim-tree").setup({
	update_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	git = {
		enable = false,
		ignore = false,
		timeout = 500,
	},
	filters = {
		dotfiles = false,
		custom = { ".git", "node_modules", ".cache", ".DS_Store", "__pycache__", ".idea", ".dist" },
	},
	respect_buf_cwd = true,
	renderer = {
		icons = {
			glyphs = {
				default = "",
				symlink = "",
			},
		},
	},
})

vim.api.nvim_create_autocmd("BufEnter", {
	command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
	nested = true,
})

Keymap("n", "<leader>n", ":NvimTreeToggle<CR>")
Keymap("n", "<leader>m", ":NvimTreeFindFile<CR>")
