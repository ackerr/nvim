-- telescope
local telescope = require("telescope")
telescope.setup({
	defaults = {
		file_ignore_patterns = {
			".git",
			"node_modules",
			".DS_Store",
			"__pycache__",
			".github",
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
})

Keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
Keymap("n", "<leader>fr", "<cmd>Telescope live_grep<CR>")
Keymap("x", "<leader>fr", 'y:Telescope live_grep<CR><c-r>"')
Keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
Keymap("n", "<leader>fg", "<cmd>Telescope git_status<CR>")
Keymap("n", "gr", "<cmd>Telescope lsp_references<CR>")

-- telescope-project
telescope.load_extension("project")
Keymap("n", "<leader>p", ":lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>")
