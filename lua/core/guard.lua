local ft = require("guard.filetype")

ft("lua"):fmt("stylua"):lint("selene")
ft("python")
  :fmt({ cmd = "black", stdin = true, args = { "--quiet", "--line-length", "120", "-" } })
  :lint({ cmd = "flake8", stdin = true, args = { "--max-line-length", "120" } })
ft("go"):fmt("gofmt"):append({ cmd = "goimports", stdin = true })
ft("rust"):fmt("rustfmt")
ft("json"):fmt({ cmd = "fixjson", stdin = true })

ft("typescript,javascript,typescriptreact"):fmt("prettier")

require("guard").setup({
  -- the only options for the setup function
  fmt_on_save = true,
  -- Use lsp if no formatter was defined for this filetype
  lsp_as_default_formatter = true,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
