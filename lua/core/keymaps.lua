function Keymap(mode, key, cmd)
	vim.api.nvim_set_keymap(mode, key, cmd, { silent = true, noremap = true })
end

Keymap("i", "jk", "<Esc>")
Keymap("n", "<leader>ev", ":edit $MYVIMRC<CR>")
Keymap("n", "<leader>sv", ":source $MYVIMRC<CR>")
Keymap("n", "<c-y>", "viwy")

-- " register
Keymap("v", "p", '"_dP')

-- " buffer
Keymap("n", "<leader>dd", ":bp|bd#<CR>") -- close current buffer
Keymap("n", "<leader>do", ":%bd|e#|bd#<CR>") -- close other buffers, except current
Keymap("n", "<leader>w", ":w<CR>")
Keymap("v", "<leader>w", ":w<CR>")
Keymap("n", "<leader>q", ":q<CR>")

-- " resize window
Keymap("n", "+", ":resize +4<CR>")
Keymap("n", "_", ":resize -4<CR>")
Keymap("n", "=", ":vertical resize +4<CR>")
Keymap("n", "-", ":vertical resize -4<CR>")

-- " move window
Keymap("n", "<c-h>", "<c-w><c-h>")
Keymap("n", "<c-j>", "<c-w><c-j>")
Keymap("n", "<c-l>", "<c-w><c-l>")
Keymap("n", "<c-k>", "<c-w><c-k>")
