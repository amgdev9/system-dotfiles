local cmp = require('cmp')

local ctags_file_exists = vim.fn.filereadable('.git/tags') == 1

local sources = {
    {name = 'nvim_lsp'},
}

if ctags_file_exists then
    table.insert(sources, {name = 'ctags'})
end

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
      require('luasnip').lsp_expand(args.body)
    end,
  },
})
