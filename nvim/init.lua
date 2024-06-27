vim.g.loaded_netrw = 1	-- Using nvim-tree as a file explorer
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("package-manager")
require("remaps")
require("telescope")
require("tree-sitter")
require("autocomplete")
require("lsp")
require("config")
require("nvim_tree")
require("color-scheme")
require("status-bar")
require("lsp-lines")
