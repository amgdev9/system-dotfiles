local dap, dapui = require("dap"), require("dapui")

dapui.setup({
    controls = {
        element = "repl",
        enabled = false,
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
        border = "single",
        mappings = {
            close = { "q", "<Esc>" }
        }
    },
    force_buffers = true,
    icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
    },
    layouts = {{
        elements = {{
            id = "stacks",
            size = 1
        }},
        position = "left",
        size = 40
    }},
    mappings = {
        edit = "e",
        expand = { "<CR>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
    },
    render = {
        indent = 1,
        max_value_lines = 100
    }
})

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- Keymaps
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, {})
vim.keymap.set("n", "<Leader>c", dap.continue, {})
vim.keymap.set("n", "<Leader>si", dap.step_into, {})
vim.keymap.set("n", "<Leader>so", dap.step_over, {})
vim.keymap.set("n", "<Leader>B", function()
    dapui.float_element("breakpoints", { position = "center" })
end, {}) 
vim.keymap.set("n", "<Leader>S", function()
    dapui.float_element("scopes", { position = "center", enter = true })
end, {})
vim.keymap.set("n", "<Leader>W", function()
    dapui.float_element("watches", { position = "center" })
end, {})
vim.keymap.set("n", "<Leader>R", function()
    dapui.float_element("repl", { position = "center" })
end, {})
vim.keymap.set("n", "<Leader>C", function()
    dapui.float_element("console", { position = "center" })
end, {})

-- UI
vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'error', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶', texthl = '', linehl = '', numhl = '' })

-- Make regular file buffers read only
local function set_all_buffers_readonly()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
      vim.api.nvim_buf_set_option(buf, "modifiable", false)
    end
  end
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = set_all_buffers_readonly,
  group = vim.api.nvim_create_augroup("StartupReadOnly", { clear = true }),
})

vim.schedule(set_all_buffers_readonly)
