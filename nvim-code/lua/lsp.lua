local telescope_builtin = require("telescope.builtin")

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
})

vim.keymap.set('', '<leader>l', ":lua vim.diagnostic.open_float()<CR>")
vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions)

vim.api.nvim_create_autocmd('LspAttach', {
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

local lsp_capabilities = {} 

-- Setup enabled LSP servers
local custom_ok, custom = pcall(require, "custom")
local enabled_lsp = custom_ok and custom.lsp or {}
local lspconfig = require("lspconfig")

for k, v in pairs(enabled_lsp) do
    local name = type(k) == "number" and v or k
    local cmd = type(k) == "number" and "NIL" or v
    if cmd == "NIL" then
        cmd = nil
    end

    if name == "kotlin" then
        local root_files = {
            'settings.gradle', 
            'settings.gradle.kts', 
            'pom.xml', 
            'build.gradle', 
            'build.gradle.kts', 
        }
        vim.lsp.config['kotlin-lsp'] = {
            filetypes = { 'kotlin' },
            cmd = { cmd, "--stdio" }, 
            root_markers = root_files,
        }
        vim.lsp.enable('kotlin-lsp')
    elseif name == "zls" then
        vim.g.zig_fmt_autosave = 0
        lspconfig.zls.setup({
            capabilities = lsp_capabilities,
        })
    elseif name == "rust_analyzer" then
        lspconfig.rust_analyzer.setup({
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
        lspconfig.pylsp.setup({
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
        if cmd ~= nil then
            lspconfig[name].setup({
                capabilities = lsp_capabilities,
                cmd = cmd
            })
        else
            lspconfig[name].setup({
                capabilities = lsp_capabilities
            })
        end
    end
end

-- Progress indicator
vim.lsp.handlers["$/progress"] = function(_, result, ctx)
  local value = result.value
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local parts = {}

  if value.title and value.title ~= "" then
    table.insert(parts, value.title)
  end

  if value.message and value.message ~= "" then
    table.insert(parts, value.message)
  end

  local content = table.concat(parts, " - ")
  content = content:gsub("[%s\r\n]+", " ")
  local msg = string.format("[%s] %s", client.name, content)

  local max_width = vim.api.nvim_get_option("columns")
  local max_msg_width = max_width - 25

  if #msg > max_msg_width then
    msg = msg:sub(1, max_msg_width - 3) .. "..."
  end

  vim.notify(msg, vim.log.levels.INFO)
end

-- LSP log format
vim.fn.writefile({}, vim.fn.stdpath("state") .. "/lsp.log") -- Clear the log on every startup

vim.lsp.log.set_format_func(function(entry)
    if type(entry) == "table" then
        return "\n" .. vim.inspect(entry)
    elseif type(entry) == "string" then
        return "\n" .. entry:gsub("\\n", "\n")
    else
        return "\n" .. entry
    end
end)
