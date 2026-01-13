require("marks").setup({})

require('notify').setup({
    timeout = 3000,
    background_colour = '#000000'
})

vim.notify = require('notify')

require("telescope").setup({
    defaults = {
        file_ignore_patterns = {".git/", "node_modules/", "vendor/", "external", ".cache/"}
    },
    pickers = {
        find_files = {
            hidden = true
        }
    }
})

if (os.getenv("TERM") == "linux") then
    vim.cmd("colorscheme default")
else
    vim.cmd("colorscheme tokyonight-night")
end
