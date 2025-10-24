require("marks").setup({

})

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

function setTheme()
    if (os.getenv("TERM") == "linux") then
        vim.cmd("colorscheme default")
    else
        vim.cmd("colorscheme nightfox")
    end
end
