local vim = vim
local opt = vim.opt

vim.g.mapleader = " "

opt.backup = false
opt.writebackup = false
opt.cmdheight = 1
opt.mouse = "a"
opt.wrap = false

opt.cursorline = true
opt.backspace = "2"
opt.updatetime = 300
opt.signcolumn = "yes"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.hlsearch = true
opt.ignorecase = true
opt.incsearch = true
opt.number = true
opt.numberwidth = 2
opt.relativenumber = false
opt.autoindent = true
opt.cindent = true
opt.smartcase = true
opt.smartindent = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.expandtab = true
opt.clipboard = "unnamedplus"
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.completeopt = { "menu", "menuone", "noselect" }
opt.swapfile = false -- 不需要.swp文件

-- fold
opt.foldenable = true
opt.foldmethod = "indent"
opt.foldlevel = 99

-- colorscheme
opt.showmode = false
opt.showtabline = 0
opt.background = "dark"
opt.termguicolors = true

vim.api.nvim_create_autocmd({ "FileType" }, { command = "set formatoptions-=ro" })
