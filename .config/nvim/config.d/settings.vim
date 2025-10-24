set t_Co=256
"set rtp+=$HOME/.pyenv/versions/3.13.5/lib/python3.13/site-packages/powerline/bindings/vim
"set rtp+=/usr/lib/python3.13/site-packages/powerline/bindings/vim/
set laststatus=2

set list
set listchars=space:·,tab:»·,eol:↵

set clipboard=unnamedplus

set colorcolumn=80

set nonumber
set norelativenumber

set expandtab
set tabstop=4
set shiftwidth=4

set wrap
set mouse=
set showcmd
set termguicolors

set foldlevel=99
set foldmethod=expr
set foldexpr=v:lua.vim.treesitter.foldexpr()
