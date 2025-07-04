source $HOME/.config/nvim/config.d/plugins.vim
source $HOME/.config/nvim/config.d/bindings.vim
source $HOME/.config/nvim/config.d/settings.vim
source $HOME/.config/nvim/config.d/variables.vim
source $HOME/.config/nvim/config.d/autocmd.vim
source $HOME/.config/nvim/config.d/setup.vim

lua require('setup')
lua require('treesitter')
lua require('lsp')
