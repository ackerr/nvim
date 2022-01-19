-- bufferline.nvim
require("bufferline").setup({
	options = {
		numbers = "ordinal",
		offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
		show_close_icon = false,
		show_buffer_close_icons = false,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, _, _)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		separator_style = "thin",
	},
})
Keymap("n", "L", ":BufferLineCycleNext<CR>")
Keymap("n", "H", ":BufferLineCyclePrev<CR>")

