local safe_require = require("utils").safe_require
local flags = safe_require("flags")

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require("mason").setup()
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
      function(server_name)
          require('lspconfig')[server_name].setup({})
      end,
      rust_analyzer = function()
          require('lspconfig').rust_analyzer.setup({
              settings = {
                  ["rust-analyzer"] = {
                      imports = {
                          granularity = {
                              group = "module",
                          },
                          prefix = "self",
                      },
                      cargo = {
                          buildScripts = {
                              enable = true,
                          },
                          targetDir = true,
                      },
                      procMacro = {
                          enable = true
                      },
                  }
              }
          })
      end,
      pylsp = function()
        require("lspconfig").pylsp.setup({
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = { enabled = false },
                        flake8 = { enabled = false },
                        pylint = { enabled = false }
                    }
                }
            }
        })
      end,
  },
})

if flags ~= nil and flags.gdscript then
    require('lspconfig').gdscript.setup({})
end
