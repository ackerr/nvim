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
	dashboard.button("<Leader> ff", "  > Find file"),
	dashboard.button("<Leader> fr", "  > Find word"),
	dashboard.button("<Leader>  p", "  > Find project"),
	dashboard.button("<Leader> rr", "  > Recent", ":Telescope oldfiles<CR>"),
	dashboard.button("<Leader> ev", "  > Settings"),
	dashboard.button("q", "  > Quit", ":qa<CR>"),
}

local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

alpha.setup(dashboard.opts)

vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
