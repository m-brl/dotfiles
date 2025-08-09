require('hologram').setup{
    auto_display = true
}

require('marks').setup({

})

require('telescope').setup({
    defaults = {
        file_ignore_patterns = {'.git/', 'node_modules/', 'vendor/', 'external', '.cache/'}
    },
    pickers = {
        find_files = {
            hidden = true
        }
    }
})

require('gitsigns').setup({
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 0,
        ignore_whitespace = false
    }
})
