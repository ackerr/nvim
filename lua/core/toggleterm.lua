local vim = vim

require("toggleterm").setup({
	size = 25,
	open_mapping = [[<M-=>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = false,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	close_on_exit = true,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

Keymap("t", "<c-w><c-w>", "<c-\\><c-n><c-w>w")
-- Keymap("n", "<m-=>", ":ToggleTerm size=25<CR>")
Keymap("v", "<leader>fs", ":ToggleTermSendVisualSelection<CR>")

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	-- vim.api.nvim_buf_set_keymap(0, "t", "<m-=>", [[<C-\><C-n>:ToggleTerm<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

-- lazygit
local lazygit = Terminal:new({ cmd = "lazygit", direction = "float" })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })

-- python
local python = Terminal:new({ cmd = "ipython", direction = "float" })

function _PYTHON_TOGGLE()
	python:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>py", "<cmd>lua _PYTHON_TOGGLE()<CR>", { noremap = true, silent = true })
