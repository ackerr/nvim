-- alpha.nvim
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local function pick_color()
	local colors = { "String", "Identifier", "Keyword", "Number" }
	return colors[math.random(#colors)]
end

dashboard.section.header.opts.hl = pick_color()

dashboard.section.buttons.val = {
	dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("f", "  > Find file", ":Telescope find_files<CR>"),
	dashboard.button("w", "  > Find word", ":Telescope live_grep<CR>"),
	dashboard.button(
		"p",
		"  > Find project",
		":lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>"
	),
	dashboard.button("r", "  > Find recent", ":Telescope oldfiles<CR>"),
	dashboard.button("s", "  > Settings", ":e $MYVIMRC<CR>"),
	dashboard.button("q", "  > Quit", ":qa<CR>"),
}

local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

alpha.setup(dashboard.opts)

vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
