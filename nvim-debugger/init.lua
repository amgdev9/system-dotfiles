vim.opt.rtp:append("~/.config/nvim-debugger/plugins/*")

-- Common config
require("config")
require("remaps")

-- Coding config
require("treesitter")
require("color-scheme")
require("finder")
require("status-bar")

-- Debugger config
require("debugger")
require("adapters")
require("configs")
