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
		use({
			"rebelot/kanagawa.nvim",
			config = function()
				require("kanagawa").setup()
			end,
		})
		use({ "goolord/alpha-nvim", requires = { "nvim-telescope/telescope.nvim" } })
		use({ "kevinhwang91/nvim-hlslens" })
		use({ "tpope/vim-surround" })
		use({ "tpope/vim-repeat" })
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})
		use({ "itchyny/vim-cursorword" })
		use({ "junegunn/vim-easy-align" })
		use({ "editorconfig/editorconfig-vim" })
		use({ "terryma/vim-multiple-cursors" })
		use({ "mg979/vim-visual-multi" })
		use({ "Vimjas/vim-python-pep8-indent", ft = "python" })
		use({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup({ "*" })
			end,
		})

		use({ "github/copilot.vim" })
		use({
			"lewis6991/gitsigns.nvim",
			event = "BufRead",
			config = function()
				require("core.gitsigns")
			end,
		})
		use({ "andrewstuart/vim-kubernetes", ft = { "yaml", "yml" } })
		use({ "cespare/vim-toml", ft = "toml" })
		use({
			"vim-test/vim-test",
			cmd = { "TestNearest", "TestSuite", "TestVisit", "TestFile", "TestLast" },
		})
		use({
			"rcarriga/vim-ultest",
			cmd = { "UltestSummary", "ultest" },
			requires = { "vim-test/vim-test" },
			run = ":UpdateRemoteuseins",
		})

		use({ "romainl/vim-cool" })
		use({ "psliwka/vim-smoothie" })
		use({ "wakatime/vim-wakatime" })
		use({ "voldikss/vim-translator", cmd = { "TranslateW" } })
		-- terminal
		use({ "voldikss/vim-floaterm" })
		use({ "akinsho/toggleterm.nvim", tag = "v1.*" })

		use({ "kyazdani42/nvim-tree.lua" })

		use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })
		use("nvim-lualine/lualine.nvim")
		-- lsp
		use("neovim/nvim-lspconfig")
		use("williamboman/nvim-lsp-installer")

		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-nvim-lsp")
		use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
		use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
		use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
		use("windwp/nvim-autopairs")
		-- lsp icon
		use("onsails/lspkind-nvim")
		-- snippet.
		use("rafamadriz/friendly-snippets")
		use("L3MON4D3/LuaSnip")
		use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
		-- lsp format
		use({
			"jose-elias-alvarez/null-ls.nvim",
			event = "BufRead",
			config = function()
				require("core.null-ls")
			end,
		})
		-- syntax
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use({ "nvim-treesitter/nvim-treesitter-textobjects", requires = { "nvim-treesitter/nvim-treesitter" } })
		use({ "romgrk/nvim-treesitter-context", requires = { "nvim-treesitter/nvim-treesitter" } })

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
