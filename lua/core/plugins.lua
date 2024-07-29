local vim = vim

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
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[
  silent! colorscheme kanagawa
  highlight VertSplit guibg=NONE
]])
    end,
  },
  { "goolord/alpha-nvim" },
  { "kevinhwang91/nvim-hlslens", lazy = true },
  { "tpope/vim-repeat", event = { "InsertEnter" }, lazy = true },
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
    lazy = true,
  },
  { "itchyny/vim-cursorword", event = "BufRead", lazy = true },
  { "junegunn/vim-easy-align", cmd = { "EasyAlign" }, lazy = true },
  { "editorconfig/editorconfig-vim", event = "BufRead", lazy = true },
  { "terryma/vim-multiple-cursors", lazy = true },
  { "mg979/vim-visual-multi", lazy = true },
  { "Vimjas/vim-python-pep8-indent", ft = "python", lazy = true },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup({ "*" })
    end,
    lazy = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("core.gitsigns")
    end,
    lazy = true,
  },
  { "romainl/vim-cool", event = "BufRead", lazy = true },
  { "psliwka/vim-smoothie", event = "BufRead", lazy = true },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  { "voldikss/vim-translator", cmd = { "TranslateW" }, lazy = true },
  { "akinsho/toggleterm.nvim", version = "*", lazy = true },
  { "kyazdani42/nvim-tree.lua", lazy = true },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  { "nvim-lualine/lualine.nvim" }, -- lsp
  { "williamboman/mason.nvim", cmd = { "Mason" }, lazy = true },
  { "williamboman/mason-lspconfig.nvim", lazy = true },
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
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    lazy = true,
  },
  {
    "j-hui/fidget.nvim",
    event = { "BufRead" },
    branch = "legacy",
    config = function()
      require("fidget").setup({})
    end,
    lazy = true,
  },
  { "sindrets/diffview.nvim", event = "BufRead", lazy = true },
  {
    "L3MON4D3/LuaSnip",
    run = "make install_jsregexp",
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
    "nvimdev/guard.nvim",
    dependencies = {
      "nvimdev/guard-collection",
    },
    event = "BufRead",
    config = function()
      require("core.guard")
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
  { "wakatime/vim-wakatime" },
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
