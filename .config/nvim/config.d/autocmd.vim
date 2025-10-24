autocmd VimEnter * Copilot disable


autocmd VimEnter,BufRead,BufNewFile *.json
    \ setlocal filetype=json | setlocal shiftwidth=2 | setlocal tabstop=2

autocmd VimEnter,BufRead,BufNewFile *.yaml,*.yml
    \ setlocal filetype=yaml | setlocal shiftwidth=2 | setlocal tabstop=2

autocmd VimEnter,BufRead,BufNewFile *.xml
    \ setlocal filetype=xml | setlocal shiftwidth=2 | setlocal tabstop=2


autocmd VimEnter,BufRead,BufNewFile *.go
    \ setlocal filetype=go | setlocal shiftwidth=8 | setlocal tabstop=8

autocmd VimEnter,BufRead,BufNewFile *.c,*.h
    \ setlocal filetype=c | setlocal shiftwidth=4 | setlocal tabstop=4

autocmd VimEnter,BufRead,BufNewFile *.cpp,*.hpp
    \ setlocal filetype=cpp | setlocal shiftwidth=2 | setlocal tabstop=2

autocmd VimEnter,BufRead,BufNewFile *.py
    \ setlocal filetype=python | setlocal shiftwidth=4 | setlocal tabstop=4
