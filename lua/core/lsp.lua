local vim = vim

local function lsp_document_highlight(client)
  if client.server_capabilities.document_highlight then
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
  buf_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  buf_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  buf_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  buf_keymap("n", "<m-k>", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  buf_keymap("n", "<m-j>", "<cmd>lua vim.diagnostic.goto_next()<CR>")
  buf_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.disable()<CR>")
end

-- lsp callback
local on_attach = function(client, bufnr)
  lsp_keymap(bufnr)
  client.server_capabilities.document_highlight = true
  if client.name == "jsonls" then
    client.server_capabilities.document_highlight = false
  end
  lsp_document_highlight(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- lsp installer

local servers = { "gopls", "rust_analyzer", "lua_ls", "pyright", "vimls", "jsonls" }
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- lsp config
local lspconfig = require("lspconfig")

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  })
end

lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    gopls = {
      usePlaceholders = false,
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = false,
        compositeLiteralTypes = true,
        constantValues = false,
        functionTypeParameters = true,
        parameterNames = false,
        rangeVariableTypes = false,
      },
    },
  },
})

lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

-- lsp diagnostic
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
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

local signs = { Error = "✘", Warn = "", Hint = "•", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
--   callback = function()
--     vim.lsp.buf.inlay_hint(0, true)
--   end,
-- })
-- vim.api.nvim_create_autocmd({ "InsertLeave" }, {
--   callback = function()
--     vim.lsp.buf.inlay_hint(0, false)
--   end,
-- })
