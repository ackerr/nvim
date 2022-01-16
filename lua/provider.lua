vim.cmd([[
    if exists("$VIRTUAL_ENV")
        let g:python_host_prog=substitute(system("which -a python2 | head -n2 | tail -n1"), '\n', '', 'g')
        let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), '\n', '', 'g')
    else
        let g:python_host_prog=substitute(system("which python2"), '\n', '', 'g')
        let g:python3_host_prog=substitute(system("which python3"), '\n', '', 'g')
    endif
]])
