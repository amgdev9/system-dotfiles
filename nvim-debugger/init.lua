vim.opt.rtp:append("~/.config/nvim-debugger/plugins/*")

-- Common config
require("config")
require("remaps")
require("color-scheme")
require("finder")
require("status-bar")

-- Coding config
require("treesitter")

-- Debugger config
require("debugger")
require("adapters")
require("configs")
