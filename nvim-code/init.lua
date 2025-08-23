vim.opt.rtp:append("~/.config/nvim-code/plugins/*")

-- Common config
require("config")
require("remaps")
require("color-scheme")
require("finder")
require("status-bar")
require("nvim_tree")

-- Coding config
require("git-gutter")
require("ai")
require("format")
require("autocomplete")
require("lsp")
require("treesitter")
