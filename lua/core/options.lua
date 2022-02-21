local vim = vim
local opt = vim.opt

vim.g.mapleader = " "

opt.cursorline = true
opt.backspace = "2"
opt.updatetime = 500
opt.signcolumn = "yes"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.number = true
opt.relativenumber = false
opt.autoindent = true
opt.smartindent = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.expandtab = true
opt.clipboard = "unnamedplus"
opt.scrolloff = 5
opt.completeopt = { "menu", "menuone", "noselect" }
opt.swapfile = false -- 不需要.swp文件

-- fold
opt.foldenable = true
opt.foldmethod = "indent"
opt.foldlevel = 99

-- colorscheme
opt.showmode = false
opt.background = "dark"
opt.termguicolors = true
