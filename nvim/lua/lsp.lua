local safe_require = require("utils").safe_require
local flags = safe_require("flags")

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
})

vim.keymap.set('', '<leader>l', ":lua vim.diagnostic.open_float()<CR>")
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>') 

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf, silent = true, noremap = true}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<leader>.', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason").setup()
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
      function(server)
          require('lspconfig')[server].setup({
              capabilities = lsp_capabilities,
          })
      end,
      rust_analyzer = function()
          require('lspconfig').rust_analyzer.setup({
              capabilities = lsp_capabilities,
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
            capabilities = lsp_capabilities,
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
      vtsls = function()
          require("lspconfig").vtsls.setup {
              filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
              settings = {
                  vtsls = { tsserver = { globalPlugins = {} } },
              },
              before_init = function(params, config)
                  if flags == nil or not flags.vue then
                      return
                  end
                  local vuePluginConfig = {
                      name = "@vue/typescript-plugin",
                      location = require("mason-registry").get_package("vue-language-server"):get_install_path()
                      .. "/node_modules/@vue/language-server",
                      languages = { "vue" },
                      configNamespace = "typescript",
                      enableForWorkspaceTypeScriptVersions = true,
                  }
                  table.insert(config.settings.vtsls.tsserver.globalPlugins, vuePluginConfig)
              end,
          }
      end,
  },
})

if flags ~= nil and flags.gdscript then
    require('lspconfig').gdscript.setup({
        capabilities = lsp_capabilities,
    })
end

if flags ~= nil and (flags.swift or flags.xcode) then
    require('lspconfig').sourcekit.setup({
        capabilities = lsp_capabilities,
        filetypes = { "swift", "objc", "objcpp", "c", "cpp" },
        on_init = function(client, initialization_result)
            -- HACK: to fix some issues with LSP
            -- more details: https://github.com/neovim/neovim/issues/19237#issuecomment-2237037154
            client.offset_encoding = "utf-8"

        end,
        get_language_id = function(_, ftype)
            if ftype == "objc" then
                return "objective-c"
            end
            if ftype == "objcpp" then
                return "objective-cpp"
            end
            return ftype
        end,
    })
end

