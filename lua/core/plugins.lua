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
	{ "kyazdani42/nvim-web-devicons" }, -- colorscheme
	{ "rebelot/kanagawa.nvim" },
	{ "goolord/alpha-nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	{ "kevinhwang91/nvim-hlslens" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{ "itchyny/vim-cursorword" },
	{ "junegunn/vim-easy-align" },
	{ "editorconfig/editorconfig-vim" },
	{ "terryma/vim-multiple-cursors" },
	{ "mg979/vim-visual-multi" },
	{ "Vimjas/vim-python-pep8-indent", ft = "python" },
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
	},
	{ "romainl/vim-cool" },
	{ "psliwka/vim-smoothie" },
	{ "voldikss/vim-translator", cmd = { "TranslateW" } },
	{ "akinsho/toggleterm.nvim", version = "*" },
	{ "kyazdani42/nvim-tree.lua" },
	{ "akinsho/bufferline.nvim", version = "v2.*", dependencies = "kyazdani42/nvim-web-devicons" },
	{ "nvim-lualine/lualine.nvim" }, -- lsp
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer", dependencies = "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-path", dependencies = "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-cmdline", dependencies = "hrsh7th/nvim-cmp" },
	{ "windwp/nvim-autopairs" },
	{ "onsails/lspkind-nvim" },
	{ "rafamadriz/friendly-snippets" },
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip", dependencies = "hrsh7th/nvim-cmp" },
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufRead",
		config = function()
			require("core.null-ls")
		end,
	},
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{ "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },
	{ "romgrk/nvim-treesitter-context", dependencies = { "nvim-treesitter/nvim-treesitter" } },
	{ "nvim-telescope/telescope.nvim" },
	{ "nvim-telescope/telescope-project.nvim" },
	-- ui = {
	-- 	icons = {
	-- 		config = "🛠",
	-- 		event = "📅",
	-- 		ft = "📂",
	-- 		init = " ",
	-- 		keys = " ",
	-- 		plugin = " ",
	-- 		runtime = "💻",
	-- 		source = " ",
	-- 		start = "🚀",
	-- 		task = "✔ ",
	-- 		lazy = "💤 ",
	-- 	},
	-- },
})

vim.cmd([[
  silent! colorscheme kanagawa
  highlight VertSplit guibg=NONE
]])

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

-- github copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

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
