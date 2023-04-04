local vim = vim
-- telescope
local telescope = require("telescope")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
telescope.setup({
	defaults = {
		layout_config = {
			horizontal = {
				preview_width = 0.55,
			},
			center = {
				height = 0.6,
				width = 0.6,
			},
		},
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-u"] = false,
				["<M-p>"] = action_layout.toggle_preview,
			},
			n = {
				["<M-p>"] = action_layout.toggle_preview,
			},
		},
		color_devicons = true,
		file_ignore_patterns = {
			".git",
			"node_modules",
			".DS_Store",
			"__pycache__",
			".idea",
		},
	},
	pickers = {
		grep_string = {
			only_sort_text = true,
		},
		live_grep = {
			--@usage don't include the filename in the search results
			only_sort_text = true,
		},
		find_files = {
			hidden = true,
			find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }, -- remove prefix ./
		},
	},
})

Keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
Keymap("n", "<leader>fr", "<cmd>Telescope live_grep<CR>")
Keymap("v", "<leader>fr", "y:Telescope live_grep default_text=<c-r>0<CR>")
Keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
Keymap("n", "<leader>fg", "<cmd>Telescope git_status<CR>")
Keymap("n", "<leader>rr", "<cmd>Telescope oldfiles<CR>")
Keymap("n", "gr", "<cmd>Telescope lsp_references theme=dropdown<CR>")
Keymap("n", "<M-CR>", "<cmd>Telescope lsp_code_actions theme=dropdown<CR><ESC>") -- alt+enter
