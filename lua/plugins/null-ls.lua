-- null-ls.nvim
local formatting = require("null-ls").builtins.formatting
local diagnostics = require("null-ls").builtins.diagnostics
require("null-ls").setup({
	sources = {
		formatting.stylua,
		formatting.goimports,
		formatting.black.with({ extra_args = { "--line-length", "120" } }),

		diagnostics.flake8,
		diagnostics.golangci_lint,
	},
})
vim.cmd([[ command! Formatting exec 'lua vim.lsp.buf.formatting()' ]])
vim.api.nvim_exec([[ autocmd BufWritePost *.py,*.go,*.lua Formatting ]], true)
