vim.g.loaded_netrw = 1	-- Using nvim-tree as a file explorer
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.opt.rtp:append("~/.config/nvim/plugins/*")

require("config")
require("remaps")
require("git-gutter")
require("tree-sitter")
require("autocomplete")
require("lsp")
require("nvim_tree")
require("color-scheme")
require("status-bar")
require("finder")
