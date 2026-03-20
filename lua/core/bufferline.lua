vim.cmd([[highlight TabLineSel guibg=#7AA89F]])

-- bufferline.nvim
require("bufferline").setup({
  highlights = {
    fill = {
      bg = "#1F1F28",
    },
    buffer_selected = {
      fg = "#b8b4a8",
      bg = "#2d2d3d",
      italic = false,
      bold = false,
    },
  },
  options = {
    numbers = "none",
    offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
    show_close_icon = false,
    show_buffer_close_icons = false,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function()
      return " "
    end,
    separator_style = "thin",
    indicator = {
      style = "none",
    },
  },
})
Keymap("n", "L", ":BufferLineCycleNext<CR>")
Keymap("n", "H", ":BufferLineCyclePrev<CR>")
