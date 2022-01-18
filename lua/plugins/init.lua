local vim = vim

vim.cmd([[
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs 
                  \https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
]])

-- Plugin
local Plug = vim.fn["plug#"]

vim.call("plug#begin", "~/.config/nvim/plugins")

-- Plug("shaunsingh/nord.nvim")
Plug("rebelot/kanagawa.nvim")
Plug("goolord/alpha-nvim")

Plug("tpope/vim-surround")
Plug("tpope/vim-repeat")
Plug("tpope/vim-commentary")
Plug("itchyny/vim-cursorword")
Plug("junegunn/vim-easy-align")
Plug("editorconfig/editorconfig-vim")
Plug("terryma/vim-multiple-cursors")
Plug("mg979/vim-visual-multi")
Plug("Vimjas/vim-python-pep8-indent")
Plug("norcalli/nvim-colorizer.lua")

Plug("github/copilot.vim")
Plug("lewis6991/gitsigns.nvim")
Plug("andrewstuart/vim-kubernetes")
Plug("fladson/vim-kitty")
Plug("cespare/vim-toml")
Plug("vim-test/vim-test")
Plug("rcarriga/vim-ultest", { ["do"] = ":UpdateRemotePlugins" })

Plug("romainl/vim-cool")
Plug("psliwka/vim-smoothie")
Plug("wakatime/vim-wakatime")
Plug("voldikss/vim-translator")
-- terminal
Plug("voldikss/vim-floaterm")

Plug("kyazdani42/nvim-web-devicons")
Plug("kyazdani42/nvim-tree.lua")
Plug("akinsho/bufferline.nvim")
Plug("nvim-lualine/lualine.nvim")
-- lsp
Plug("neovim/nvim-lspconfig")
Plug("williamboman/nvim-lsp-installer")
-- lsp completion
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp")
Plug("windwp/nvim-autopairs")
-- lsp icon
Plug("onsails/lspkind-nvim")
-- lsp format
Plug("jose-elias-alvarez/null-ls.nvim")
-- syntax
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug("SmiteshP/nvim-gps")
-- search
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("nvim-telescope/telescope-project.nvim")
-- snippet.
Plug("rafamadriz/friendly-snippets")
Plug("hrsh7th/cmp-vsnip")
Plug("hrsh7th/vim-vsnip")

vim.call("plug#end")

-- colorscheme
-- vim.g.nord_enable_sidebar_background = false
-- vim.g.nord_contrast = true
-- vim.g.nord_disable_background = false
require("kanagawa").setup({})
vim.cmd([[ silent! colorscheme kanagawa ]])

-- vim-commentary
Keymap("n", "<leader>/", ":Commentary<CR>")
Keymap("v", "<leader>/", ":Commentary<CR>")

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

-- splitjoin
Keymap("n", "sj", ":SplitjoinSplit<CR>")
Keymap("n", "sk", ":SplitjoinJoin<CR>")

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
