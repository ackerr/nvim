-- telescope
Keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
Keymap("n", "<leader>fr", "<cmd>Telescope live_grep<CR>")
Keymap("x", "<leader>fr", 'y:Telescope live_grep<CR><c-r>"')
Keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
Keymap("n", "<leader>fg", "<cmd>Telescope git_status<CR>")
Keymap("n", "gr", "<cmd>Telescope lsp_references<CR>")

-- telescope-project
require("telescope").load_extension("project")
Keymap("n", "<leader>p", ":lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>")
