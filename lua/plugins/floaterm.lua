-- vim-floaterm
Keymap("n", "<leader>ft", ":FloatermNew --wintype=normal --position=bottom --height=20<CR>")
Keymap("n", "<leader>fp", ":FloatermNew --wintype=normal --position=right --width=0.5 --name=ipy ipython<CR>")
Keymap("v", "<leader>fs", ":FloatermSend<CR>")
Keymap("t", "<m-]>", "<c-\\><c-n>:FloatermNext<CR>")
Keymap("t", "<m-[>", "<c-\\><c-n>:FloatermP<c-\\><c-n><c-w>w")
Keymap("t", "<c-w><c-w>", "<c-\\><c-n><c-w>w")

-- lazygit
Keymap("n", "<leader>lg", ":FloatermNew --height=0.8 --width=0.8 --name=lazygit lazygit<CR>")

vim.g.floaterm_keymap_toggle = "<m-=>"
vim.g.floaterm_keymap_kill = "<m-q>"
vim.g.floaterm_autoclose = 1
vim.g.floaterm_width = 0.7
vim.g.floaterm_height = 0.6
