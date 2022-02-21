local vim = vim

vim.cmd([[ autocmd BufNewFile,BufRead *.thrift setlocal filetype=thrift ]])
