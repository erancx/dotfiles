local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

lazy.setup({
    spec = {
        {
            "catppuccin/nvim",
            lazy = false,
            priority = 1000,
        },
        { "SmiteshP/nvim-navic" },
        { "akinsho/nvim-bufferline.lua" },
        { "jvirtanen/vim-hcl" },
        { "akinsho/nvim-toggleterm.lua" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "beauwilliams/focus.nvim" },
        { "danymat/neogen" },
        { "famiu/bufdelete.nvim" },
        { "folke/trouble.nvim" },
        { "folke/which-key.nvim" },
        { "catppuccin/nvim" },
        { "nvim-tree/nvim-tree.lua" },
        { "lukas-reineke/indent-blankline.nvim" },
        { "neovim/nvim-lspconfig" },
        { "norcalli/nvim-colorizer.lua" },
        { "ntpeters/vim-better-whitespace" },
        { "nvim-lua/lsp-status.nvim" },
        { "lewis6991/impatient.nvim" },
        { "nvim-lualine/lualine.nvim" },
        { "tpope/vim-fugitive" },
        { "wbthomason/packer.nvim" },
        { "sindrets/diffview.nvim" },
        { "jjo/vim-cue" },
        { "onsails/lspkind-nvim" },
        { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = function()
                require("nvim-autopairs").setup({})
            end,
        },
        {
            "lewis6991/gitsigns.nvim",
            lazy = true,
            dependencies = {
                "nvim-lua/plenary.nvim",
                "kyazdani42/nvim-web-devicons",
            },
            config = function()
                require("gitsigns").setup({})
            end,
        },
        {
            "echasnovski/mini.move",
            config = function()
                require("mini.move").setup()
            end,
        },
        {
            "utilyre/barbecue.nvim",
            config = function()
                require("barbecue").setup({})
            end,
        },
        {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end,
        },
        {
            "kylechui/nvim-surround",
            config = function()
                require("nvim-surround").setup({})
            end,
        },
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = false },
                "nvim-telescope/telescope-project.nvim",
                "nvim-telescope/telescope-file-browser.nvim",
            },
        },
        {
            "jose-elias-alvarez/null-ls.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "neovim/nvim-lspconfig",
            },
        },
        {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            dependencies = {
                "L3MON4D3/LuaSnip",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-buffer",
                "saadparwaiz1/cmp_luasnip",
            },
        },
    },
})
