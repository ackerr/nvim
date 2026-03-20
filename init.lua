-- Disable netrw before anything else
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("core.options")
require("core.keymaps")
require("core.provider")
require("core.filetype")
require("core.plugins")
require("core.lsp")
require("core.completion")
require("core.alpha")
require("core.lualine")
require("core.bufferline")
require("core.noice")
require("core.toggleterm")
-- nvim-tree config is now loaded in plugins.lua
require("core.telescope")
require("core.treesitter")
