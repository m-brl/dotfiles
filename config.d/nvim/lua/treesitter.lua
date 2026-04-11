vim.api.nvim_create_autocmd("FileType", {
    pattern = { "java", "c", "cpp", "python" },
    callback = function()
        vim.treesitter.start()
    end
})

require("treesitter-context").setup {
    enable = true,
    multiwindow = true,
    max_lines = 1,
    trim_scope = 'inner',
    mode = 'topline'
}
