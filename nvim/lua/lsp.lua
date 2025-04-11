local telescope_builtin = require("telescope.builtin")
local autocomplete = require("autocomplete")

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
})

vim.keymap.set('', '<leader>l', ":lua vim.diagnostic.open_float()<CR>")
vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    autocomplete.setup(event)
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

local lsp_capabilities = {} 

-- Setup enabled LSP servers
local enabled_lsp = require("custom").lsp
local lspconfig = require("lspconfig")
for i = 1, #enabled_lsp do
    local name = enabled_lsp[i]
    if name == "zls" then
        vim.g.zig_fmt_autosave = 0
        lspconfig.zls.setup({
            capabilities = lsp_capabilities,
        })
    elseif name == "rust_analyzer" then
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
    elseif name == "pylsp" then
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
    elseif name == "sourcekit" then
        lspconfig.sourcekit.setup({
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
    else
        lspconfig[name].setup({
            capabilities = lsp_capabilities
        })
    end
end

require("lsp-file-operations").setup()
