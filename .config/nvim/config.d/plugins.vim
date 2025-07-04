call plug#begin('~/.local/state/nvim/plugged')

" [----- GIT -----]
Plug 'tpope/vim-fugitive' " Git command wrapper
Plug 'airblade/vim-gitgutter' " Show git diff
Plug 'f-person/git-blame.nvim' " Show git blame

" [----- NERDTree -----]
Plug 'scrooloose/nerdtree' " Browsing tree
Plug 'unkiwii/vim-nerdtree-sync' " Sync nerdtree cursor with actual file
Plug 'xuyuanp/nerdtree-git-plugin' " Show git diff on nerdtree

" [-----  treesitter -----]
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/playground'

" [----- nvim-cmp -----]
Plug 'mason-org/mason.nvim'
Plug 'mason-org/mason-lspconfig.nvim'

Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

" [----- Code completion -----]
Plug 'tpope/vim-endwise' " Auto close structures (if -> fi)
Plug 'github/copilot.vim' " Github Copilot
Plug 'raimondi/delimitmate' " Auto close parentheses
" Plug 'neoclide/coc.nvim', {'branch': 'release'} " Code completion

" [----- Browse and navigation -----]
Plug 'majutsushi/tagbar' " Tagbar
Plug 'mg979/vim-visual-multi' " Multiline cursor

Plug 'nvim-lua/plenary.nvim' " Telescope dependency
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' } " File browsing

" [----- UI -----]
Plug 'ap/vim-css-color' " Display hexa colors
Plug 'tpope/vim-surround' " Delete, change, add parentheses / quotes...
Plug 'ryanoasis/vim-devicons' " Add dev icons
Plug 'vim-airline/vim-airline' " Vim line
Plug 'bronson/vim-trailing-whitespace' " Show trailing whitespace

" [----- UTILS -----]
Plug 'thinca/vim-localrc' " Local project config
Plug 'chentoast/marks.nvim' " Markers display
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' } " Markdown preview engine
Plug 'andweeb/presence.nvim' " Discord Rich Presence

" [----- DB -----]
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'

" [----- THEMES -----]
Plug 'tomasr/molokai'
Plug 'Mofiqul/adwaita.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'NLKNguyen/papercolor-theme'

" [---- DISABLED -----]
" Plug 'nvim-tree/nvim-web-devicons'
" Plug 'ludovicchabant/vim-gutentags'

call plug#end()
