local vim = vim

local function lsp_document_highlight(client)
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
            augroup lsp_document_highlight
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
            ]],
			false
		)
	end
end

local function lsp_keymap(bufnr)
	local function buf_keymap(mode, key, cmd)
		vim.api.nvim_buf_set_keymap(bufnr, mode, key, cmd, { noremap = true, silent = true })
	end

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
	buf_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	buf_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
	buf_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	buf_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
	buf_keymap("n", "<m-k>", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
	buf_keymap("n", "<m-j>", "<cmd>lua vim.diagnostic.goto_next()<CR>")
	buf_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.disable()<CR>")
	buf_keymap("n", "<leader>cs", "<cmd>lua vim.lsp.buf.code_action()<CR>")
end

-- lsp callback
local on_attach = function(client, bufnr)
	if client.name == "gopls" then
		client.resolved_capabilities.document_formatting = false
	end

	lsp_keymap(bufnr)
	lsp_document_highlight(client)
end

-- lsp installer
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = capabilities,
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
	}
	server:setup(opts)
end)

-- lsp diagnostic
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = false,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- lsp config
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})
