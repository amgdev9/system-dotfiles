local dap, dapui = require("dap"), require("dapui")

dapui.setup()

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

-- UI
vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'error', linehl = '', numhl = '' })
