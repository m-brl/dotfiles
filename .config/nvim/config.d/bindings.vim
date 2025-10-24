" Tagbar shortcut
nnoremap <F7> <C-o>
nnoremap <F8> <C-]>
nnoremap <F10> <cmd>:Tagbar<CR>

" Unbind
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <End> <Nop>
nnoremap <Home> <Nop>
let g:copilot_no_tab_map = v:true
inoremap <silent><expr> <C-CR> copilot#Accept("\<CR>")

" Tab (disabled, use buffer instead)
" nnoremap <C-x>t <cmd>:tabnew<CR>
" nnoremap <C-x>w <cmd>:tabclose<CR>
" nnoremap <C-x>h <cmd>:tabprevious<CR>
" nnoremap <C-x>l <cmd>:tabnext<CR>

" Git
nnoremap <leader>ga <cmd>Git add %<CR>
nnoremap gc <cmd>Git commit<CR>
nnoremap gp <cmd>Git push<CR>

" Buffer
nnoremap bp <cmd>bprevious<CR>
nnoremap bn <cmd>bnext<CR>
nnoremap bdc <cmd>bdelete<CR>
nnoremap bda <cmd>%bdelete<CR>

" Telescope
nnoremap ffs <cmd>Telescope find_files<CR>
nnoremap fts <cmd>Telescope tags<CR>

" UI
nnoremap bgs <cmd>lua switchTheme()<CR>

" Utils
nnoremap bo <cmd>CocCommand git.browserOpen<CR>
