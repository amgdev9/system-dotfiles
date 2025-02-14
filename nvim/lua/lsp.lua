local safe_require = require("utils").safe_require
local flags = safe_require("flags")
local telescope_builtin = require("telescope.builtin")

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
})

vim.keymap.set('', '<leader>l', ":lua vim.diagnostic.open_float()<CR>")
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>') 

local ctags_exists = vim.fn.filereadable('.git/tags') == 1

if ctags_exists then
    vim.keymap.set('n', 'gd', function()
        local word = vim.fn.expand('<cword>')
        vim.cmd('tag ' .. word)
    end)
else
    vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions)
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf, silent = true, noremap = true}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, opts)
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
      ["volar"] = function()
          require("lspconfig").volar.setup({
              filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },
              root_dir = require("lspconfig").util.root_pattern(
              "vite.config.js",
              "vite.config.ts",
              "vue.config.js",
              "vue.config.ts",
              "nuxt.config.js",
              "nuxt.config.ts"
              ),
              init_options = {
                  vue = {
                      hybridMode = false,
                  },
              },
              capabilities = lsp_capabilities,
              settings = {
                  typescript = {
                      inlayHints = {
                          enumMemberValues = {
                              enabled = true,
                          },
                          functionLikeReturnTypes = {
                              enabled = true,
                          },
                          propertyDeclarationTypes = {
                              enabled = true,
                          },
                          parameterTypes = {
                              enabled = true,
                              suppressWhenArgumentMatchesName = true,
                          },
                          variableTypes = {
                              enabled = true,
                          },
                      },
                  },
              },
          })
      end,
      ["ts_ls"] = function()
          if flags ~= nil and not flags.vue then
              require("lspconfig").ts_ls.setup({
                  capabilities = lsp_capabilities,
              })
              return
          end

          -- Volar (vue ls) integration with ts_ls
          local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
          local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

          require("lspconfig").ts_ls.setup({
             init_options = {
                  plugins = {
                      {
                          name = "@vue/typescript-plugin",
                          location = volar_path,
                          languages = { "vue" },
                      },
                  },
              },
              capabilities = lsp_capabilities,
              settings = {
                  typescript = {
                      tsserver = {
                          useSyntaxServer = false,
                      },
                      inlayHints = {
                          includeInlayParameterNameHints = "all",
                          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                          includeInlayFunctionParameterTypeHints = true,
                          includeInlayVariableTypeHints = true,
                          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                          includeInlayPropertyDeclarationTypeHints = true,
                          includeInlayFunctionLikeReturnTypeHints = true,
                          includeInlayEnumMemberValueHints = true,
                      },
                  },
              },
          })
      end
    },
})

if flags ~= nil and flags.gdscript then
    require('lspconfig').gdscript.setup({
        capabilities = lsp_capabilities,
    })
end

if flags ~= nil and flags.swift then
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

