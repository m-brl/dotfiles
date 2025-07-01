require("mason").setup()

require("mason-lspconfig").setup {
    automatic_enable = true
}

local cmp = require('cmp')
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = cmp.config.sources(
        {
            {
                name = 'nvim_lsp'
            },
            {
                name = 'luasnip'
            },
            {
                name = 'buffer'
            },
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
        })
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
