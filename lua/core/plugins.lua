local vim = vim
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstarp
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstarp = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Plugin
packer.startup({
	function(use)
		use("wbthomason/packer.nvim")
		use("nvim-lua/popup.nvim")
		use("nvim-lua/plenary.nvim")
		use("kyazdani42/nvim-web-devicons")
		-- colorscheme
		use("shaunsingh/nord.nvim")
		use({
			"rebelot/kanagawa.nvim",
			config = function()
				require("kanagawa").setup()
			end,
		})
		use({ "goolord/alpha-nvim", requires = { "nvim-telescope/telescope.nvim" } })

		use("tpope/vim-surround")
		use("tpope/vim-repeat")
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})
		use("itchyny/vim-cursorword")
		use("junegunn/vim-easy-align")
		use("editorconfig/editorconfig-vim")
		use("terryma/vim-multiple-cursors")
		use("mg979/vim-visual-multi")
		use({ "Vimjas/vim-python-pep8-indent", ft = "python" })
		use("norcalli/nvim-colorizer.lua")

		use("github/copilot.vim")
		use("lewis6991/gitsigns.nvim")
		use({ "andrewstuart/vim-kubernetes", ft = { "yaml", "yml" } })
		use({ "cespare/vim-toml", ft = "toml" })
		use({ "vim-test/vim-test", cmd = { "TestNearest", "TestSuite", "TestVisit", "TestFile", "TestLast" } })
		use({
			"rcarriga/vim-ultest",
			cmd = { "UltestSummary", "ultest" },
			requires = { "vim-test/vim-test" },
			run = ":UpdateRemoteuseins",
		})

		use("romainl/vim-cool")
		use("psliwka/vim-smoothie")
		use("wakatime/vim-wakatime")
		use({ "voldikss/vim-translator", cmd = { "TranslateW" } })
		-- terminal
		use("voldikss/vim-floaterm")

		use("kyazdani42/nvim-tree.lua")
		use("akinsho/bufferline.nvim")
		use("nvim-lualine/lualine.nvim")
		-- lsp
		use("neovim/nvim-lspconfig")
		use("williamboman/nvim-lsp-installer")

		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/nvim-cmp")
		use("windwp/nvim-autopairs")
		-- lsp icon
		use("onsails/lspkind-nvim")
		-- snippet.
		use("rafamadriz/friendly-snippets")
		use("hrsh7th/cmp-vsnip")
		use("hrsh7th/vim-vsnip")
		-- lsp format
		use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } })
		-- syntax
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use({ "SmiteshP/nvim-gps", requires = { "neovim/nvim-lspconfig" } })
		-- search
		use("nvim-telescope/telescope.nvim")
		use("nvim-telescope/telescope-project.nvim")
	end,

	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	},
})

if packer_bootstarp then
	require("packer").sync()
end

-- colorscheme
-- vim.g.nord_enable_sidebar_background = false
-- vim.g.nord_contrast = true
-- vim.g.nord_disable_background = false
vim.cmd([[
  silent! colorscheme kanagawa
  highlight VertSplit guibg=NONE
]])

-- comment.nvim
Keymap("n", "<C-_>", "gcc", { noremap = false })
Keymap("v", "<C-_>", "gc", { noremap = false })

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

-- vim-test and vim-ultest
Keymap("n", "tn", ":TestNearest<CR>")
Keymap("n", "tf", ":TestFile<CR>")
Keymap("n", "ts", ":TestSuite<CR>")
Keymap("n", "tl", ":TestLast<CR>")
Keymap("n", "tg", ":TestVisit<CR>")
Keymap("n", "tt", ":UltestSummary<CR>")

vim.g["test#strategy"] = "floaterm"
vim.g["test#python#runner"] = "pytest"
vim.g["test#go#runner"] = "gotest"
vim.g["ultest_use_pty"] = 1

-- github copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
