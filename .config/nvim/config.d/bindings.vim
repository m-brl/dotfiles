" Tagbar shortcut
nnoremap <F7> <C-o>
nnoremap <F8> <C-]>
nnoremap <F10> <cmd>:Tagbar<Enter>

" Unbind
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <End> <Nop>
nnoremap <Home> <Nop>

" Tab shortcut
nnoremap <C-x>t <cmd>:tabnew<Enter>
nnoremap <C-x>w <cmd>:tabclose<Enter>
nnoremap <C-x>h <cmd>:tabprevious<Enter>
nnoremap <C-x>l <cmd>:tabnext<Enter>

" Shortcut
nnoremap bp <cmd>:bprevious<Enter>
nnoremap bn <cmd>:bnext<Enter>
nnoremap bd <cmd>:bdelete<Enter>

nnoremap ffs <cmd>Telescope find_files<Enter>
nnoremap fts <cmd>Telescope tags<Enter>

nnoremap bgs <cmd>lua switchTheme()<Enter>
nnoremap bo <cmd>CocCommand git.browserOpen<Enter>
