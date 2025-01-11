local safe_require = require("utils").safe_require
local flags = safe_require("flags")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',    
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'delphinus/cmp-ctags',
    'L3MON4D3/LuaSnip',
    { 'echasnovski/mini.diff', version = false },
    'nvim-tree/nvim-tree.lua',
    'nvim-tree/nvim-web-devicons',
    'nvim-lualine/lualine.nvim',
    "github/copilot.vim",
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
    {
        "rockyzhang24/arctic.nvim",
        branch = "v2",
        dependencies = { "rktjmp/lush.nvim" }
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    flutter_tools = flags ~= nil and flags.flutter and {
        'akinsho/flutter-tools.nvim',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = true,
    } or nil,
    xcodebuild = flags ~= nil and flags.xcode and {
        "wojciech-kulik/xcodebuild.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-tree.lua",
            "nvim-treesitter/nvim-treesitter", 
        },
        config = function()
            require("xcodebuild").setup({})
        end,
    } or nil
})
