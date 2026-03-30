local vim = vim

local function lsp_document_highlight(client)
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
            augroup lsp_document_highlight
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorHold <buffer> lua vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor" })
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
  buf_keymap("n", "gd", "<cmd>Telescope lsp_definitions theme=dropdown<CR>")
  buf_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  buf_keymap("n", "gi", "<cmd>Telescope lsp_implementations theme=dropdown<CR>")
  buf_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  buf_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  buf_keymap("n", "gr", "<cmd>Telescope lsp_references theme=dropdown<CR>")
  vim.keymap.set("n", "gp", function()
    local params = vim.lsp.util.make_position_params()
    local done = false
    vim.lsp.buf_request(bufnr, "textDocument/definition", params, function(_, result)
      if done or not result or vim.tbl_isempty(result) then return end
      done = true
      local loc = vim.islist(result) and result[1] or result
      local uri = loc.uri or loc.targetUri
      local range = loc.range or loc.targetSelectionRange
      local target_bufnr = vim.uri_to_bufnr(uri)
      vim.fn.bufload(target_bufnr)
      local start_line = range.start.line
      local end_line = math.min(start_line + 15, vim.api.nvim_buf_line_count(target_bufnr))
      local lines = vim.api.nvim_buf_get_lines(target_bufnr, start_line, end_line, false)
      local float_buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, lines)
      local ft = vim.bo[target_bufnr].filetype
      if ft ~= "" then vim.bo[float_buf].filetype = ft end
      vim.api.nvim_open_win(float_buf, true, {
        relative = "cursor", row = 1, col = 0,
        width = math.min(80, vim.o.columns - 4),
        height = #lines,
        style = "minimal", border = "rounded",
      })
      vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = float_buf, silent = true })
    end)
  end, { buffer = bufnr, noremap = true, silent = true })
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

-- mason
local servers = { "gopls", "rust_analyzer", "lua_ls", "pyright", "vimls", "jsonls", "ts_ls" }
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
  automatic_enable = false,
})

-- lsp config (Nvim 0.11+ native API)
local server_settings = {
  gopls = {
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
  pyright = {
    python = {
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    settings = server_settings[server] or {},
  })
end

vim.lsp.enable(servers)

-- lsp diagnostic
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "•",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
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
