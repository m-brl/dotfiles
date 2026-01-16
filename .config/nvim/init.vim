source $HOME/.config/nvim/config.d/autocmd.vim
source $HOME/.config/nvim/config.d/plugins.vim

lua require('config')
lua require('setup')
lua require('treesitter')
lua require('lsp')
