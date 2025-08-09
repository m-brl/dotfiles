" Setup python
let g:airline_powerline_fonts = 1
let g:python3_host_prog = '$HOME/.pyenv/versions/3.13.5/bin/python'

let mapleader = ","

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Markdown
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1

" Nerdtree
let g:NERDTreeShowHidden=1
let g:NERDTreeRespectWildIgnore=1
let g:nerdtree_sync_cursorline=0
