-- lualine.nvim and nvim-gps
-- require("nvim-gps").setup()
-- local gps = require("nvim-gps")

local colors = {
  background = "#1F1F28",
  foreground = "#DCD7BA",
  blue = "#7E9CD8",
  cyan = "#6A9589",
  red = "#C34043",
  violet = "#938aa9",
  grey = "#393850",
  green = "#76946A",
  yellow = "#C0A36E",
}

local kanagawa_theme = {
  normal = {
    a = { fg = colors.background, bg = colors.blue },
    b = { fg = colors.blue, bg = colors.grey },
    c = { fg = colors.foreground, bg = colors.background },
  },

  insert = { a = { fg = colors.background, bg = colors.yellow } },
  visual = { a = { fg = colors.background, bg = colors.violet } },
  replace = { a = { fg = colors.background, bg = colors.red } },

  inactive = {
    a = { fg = colors.foreground, bg = colors.background },
    b = { fg = colors.foreground, bg = colors.background },
    c = { fg = colors.background, bg = colors.background },
  },
}

require("lualine").setup({
  options = {
    -- theme = "auto",
    theme = kanagawa_theme,
    component_separators = "",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {
      { "mode", separator = { left = "" }, right_padding = 2 },
    },
    lualine_b = { "branch", "diff" },
    lualine_c = { "filename" },
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = {
      {
        function()
          local loc = require("lualine.components.location")()
          local sel = require("lualine.components.selectioncount")()
          if sel ~= "" then
            loc = loc .. " (" .. sel .. " sel)"
          end
          return loc
        end,
        separator = { right = "" },
        left_padding = 2,
      },
    },
  },
  extensions = { "toggleterm" },
})
