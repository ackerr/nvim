local vim = vim
local fn = vim.fn

-- Automatically install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Plugin
require("lazy").setup({
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "kyazdani42/nvim-web-devicons", lazy = true },
	{
		"rebelot/kanagawa.nvim",
		config = function()
			vim.cmd([[
  silent! colorscheme kanagawa
  highlight VertSplit guibg=NONE
]])
		end,
	},
	{ "goolord/alpha-nvim" },
	{ "kevinhwang91/nvim-hlslens", lazy = true },
	{ "tpope/vim-repeat", lazy = true },
	{
		"kylechui/nvim-surround",
		event = { "BufReadPost", "BufNewFile" },
		config = true,
		lazy = true,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_filetype = { "TelescopePrompt", "vim" },
			check_ts = true,
		},
		lazy = true,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{ "itchyny/vim-cursorword" },
	{ "junegunn/vim-easy-align", lazy = true },
	{ "editorconfig/editorconfig-vim" },
	{ "terryma/vim-multiple-cursors", lazy = true },
	{ "mg979/vim-visual-multi", lazy = true },
	{ "Vimjas/vim-python-pep8-indent", ft = "python", lazy = true },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("core.gitsigns")
		end,
		lazy = true,
	},
	{ "romainl/vim-cool" },
	{ "psliwka/vim-smoothie" },
	{ "voldikss/vim-translator", cmd = { "TranslateW" }, lazy = true },
	{ "akinsho/toggleterm.nvim", version = "*", lazy = true },
	{ "kyazdani42/nvim-tree.lua" },
	{ "akinsho/bufferline.nvim", version = "v2.*", dependencies = "kyazdani42/nvim-web-devicons" },
	{ "nvim-lualine/lualine.nvim" }, -- lsp
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
		},
		lazy = true,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				vim.schedule(function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end)
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
		lazy = true,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufRead",
		config = function()
			require("core.null-ls")
		end,
		lazy = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
		},
		lazy = true,
	},
	{ "nvim-telescope/telescope.nvim", lazy = true },
})

-- comment.nvim
Keymap("n", "<C-/>", "gcc", { noremap = false })
Keymap("v", "<C-/>", "gc", { noremap = false })

-- vim-easy-align
Keymap("x", "ga", ":EasyAlign<CR>")
Keymap("n", "ga", ":EasyAlign<CR>")
vim.g.easy_align_delimiters = {
	[">"] = {
		pattern = ">>\\|\\|=>\\|>",
	},
	["/"] = {
		pattern = "//\\+\\|/\\*\\|\\*/",
		delimiter_align = "l",
		ignore_groups = { "!Comment" },
	},
	["#"] = {
		pattern = "#\\+",
		delimiter_align = "l",
		ignore_groups = { "String" },
	},
}

-- vim-translator
Keymap("n", "<M-t>", ":TranslateW<CR>")
Keymap("v", "<M-t>", ":TranslateW<CR>")

-- hlslens
require("hlslens").setup({
	nearest_only = true,
})

Keymap("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
Keymap("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
Keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]])
Keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]])

vim.cmd([[
    aug VMlens
        au!
        au User visual_multi_start lua require('vmlens').start()
        au User visual_multi_exit lua require('vmlens').exit()
    aug END
]])

vim.api.nvim_command("filetype plugin indent on")
