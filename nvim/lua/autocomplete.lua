local cmp = require('cmp')

local sources = {
    {name = 'nvim_lsp'},
}

require("cmp_nvim_lsp").setup()

cmp.setup({
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  sources = sources,
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<C-Space>'] = cmp.mapping.complete(),
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})
