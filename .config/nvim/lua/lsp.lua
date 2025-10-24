require("mason").setup()

require("mason-lspconfig").setup {
    automatic_enable = true,
    ensure_installed = {"pyright", "tsserver", "rust_analyzer"}
}

local cmp = require('cmp')
local lspkind = require("lspkind")

cmp.setup {
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.scroll_docs(4),
        ["<C-j>"] = cmp.mapping.scroll_docs(-4),
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
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
        })
    }
}


local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig['clangd'].setup {
    capabilities = capabilities
}

lspconfig['pyright'].setup {
    capabilities = capabilities
}

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
