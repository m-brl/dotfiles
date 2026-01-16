-- Define options

vim.opt.laststatus = 3

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.wrap = true
vim.opt.showcmd = true
vim.opt.termguicolors = true

vim.opt.list = true
vim.opt.listchars = { space = '·', tab = '» ', eol = '↵', extends = '›', precedes = '‹' }

vim.opt.clipboard = 'unnamedplus'

vim.opt.colorcolumn = '80'

vim.expandtab = true
vim.shiftwidth = 4
vim.tabstop = 4
vim.softtabstop = 4

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99

-- Define variables

vim.g['mapleader'] = ' '

vim.g['copilot_no_tab_map'] = true
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#fnamemod'] = ':t'

vim.g['mkdp_auto_start'] = 0
vim.g['mkdp_auto_close'] = 1

vim.g['airline_powerline_fonts'] = 1
vim.g['python3_host_prog'] = '$HOME/.pyenv/versions/3.13.5/bin/python'


vim.lsp.inlay_hint.enable(true)

-- Key mappings

vim.keymap.set('i', '<C-CR>', 'copilot#Accept("<CR>")', { expr = true, silent = true, replace_keycodes = false })

-- Enable / disable hints
vim.keymap.set('n', '<leader>h', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    vim.notify(vim.lsp.inlay_hint.is_enabled() and "Inlay Hints Enabled" or "Inlay Hints Disabled")
end)

vim.keymap.set('n', '<leader>cs', function()
    local status = vim.fn['copilot#Enabled']()
    if status == 1 then
        vim.cmd('Copilot disable')
        vim.notify("Copilot Disabled", "warn")
    else
        vim.cmd('Copilot enable')
        vim.notify("Copilot Enabled")
    end
end)

-- Save file and notify
vim.keymap.set('n', '<leader>s', function()
    vim.cmd('w')
    vim.notify('Saved ' .. vim.api.nvim_buf_get_name(0))
end)
