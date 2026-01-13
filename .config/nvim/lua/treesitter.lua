require("nvim-treesitter").setup {
    ensure_installed = { "c", "cpp", "python", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        }
    },
    refactor = {
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr"
            }
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<a-*>",
                goto_previous_usage = "<a-#>",
            },
        },
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false
    }
}

require("treesitter-context").setup {
    enable = true,
    multiwindow = true,
    max_lines = 1,
    trim_scope = 'inner',
    mode = 'topline'
}
