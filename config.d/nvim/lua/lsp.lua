local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup {
    mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.scroll_docs(4),
        ['<C-j>'] = cmp.mapping.scroll_docs(-4),
        --["C-Space"] = cmp.mapping.complete()
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered({
            max_height = 20,
            max_width = 80
        }),
    },
    sources = cmp.config.sources({
        {name = 'nvim_lsp'},
        {name = 'luasnip'},
        {name = 'buffer'},
        {name = 'calc'},
        {
            name = 'path',
            option = {
                pathMappings = {
                    ['@'] = '${folder}/src',
                    -- ['/'] = '${folder}/src/public/',
                    -- ['~@'] = '${folder}/src',
                    -- ['/images'] = '${folder}/src/images',
                    -- ['/components'] = '${folder}/src/components',
                },
            }
        }
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
        })
    }
}


local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('clangd', {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
    root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt', '.git' },
    capabilities = capabilities,
    settings = {
        clangd = {
            InlayHints = {
                Designators = true,
                Enabled = true,
                ParameterNames = true,
                DeducedTypes = true,
            },
        },
    },
})
vim.lsp.enable('clangd')

vim.lsp.config('jdtls', {
    cmd = { 'jdtls' },
    filetypes = { 'java' },
    capabilities = capabilities,
    root_markers = { 'pom.xml', 'build.gradle', '.git' },
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
        },
    },
})
vim.lsp.enable('jdtls')

vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
            },
        },
    },
})
vim.lsp.enable('pyright')

--vim.lsp.config('pyright', {
--    capabilities = capabilities
--})

vim.diagnostic.config({
  virtual_text = {
    source = "always",
    prefix = '●',
  },
  float = {
    source = "always",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

