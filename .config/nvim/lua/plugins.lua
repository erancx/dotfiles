local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute("packadd packer.nvim")
end

vim.cmd("autocmd BufWritePost plugins.lua PackerCompile") -- Auto compile when there are changes in plugins.lua

local packer = require("packer")
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
        prompt_border = "single",
    },
    git = {
        clone_timeout = 600,
    },
    auto_clean = true,
    compile_on_sync = true,
})

packer.startup(function(use)
    use("SmiteshP/nvim-gps")
    use("akinsho/nvim-bufferline.lua")
    use("akinsho/nvim-toggleterm.lua")
    use("b3nj5m1n/kommentary")
    use("beauwilliams/focus.nvim")
    use("danymat/neogen")
    use("famiu/bufdelete.nvim")
    use("folke/trouble.nvim")
    use("folke/which-key.nvim")
    use("kyazdani42/nvim-tree.lua")
    use("kyazdani42/nvim-web-devicons")
    use("lewis6991/gitsigns.nvim")
    use("lukas-reineke/indent-blankline.nvim")
    use("marko-cerovac/material.nvim")
    use("neovim/nvim-lspconfig")
    use("norcalli/nvim-colorizer.lua")
    use("ntpeters/vim-better-whitespace")
    use("nvim-lua/lsp-status.nvim")
    use("nvim-lualine/lualine.nvim")
    use("ray-x/lsp_signature.nvim")
    use("tpope/vim-fugitive")
    use("wbthomason/packer.nvim")
    use("williamboman/nvim-lsp-installer")
    use("windwp/nvim-autopairs")
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    })
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "nvim-telescope/telescope-project.nvim" },
            { "nvim-telescope/telescope-file-browser.nvim" },
        },
    })
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })
    -- auto-completion
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            "saadparwaiz1/cmp_luasnip",
            { "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" },
        },
    })
    use({ "onsails/lspkind-nvim", config = [[ require('plugins.lsp.lspkind') ]] })
    use({
        "L3MON4D3/LuaSnip",
        requires = {
            "rafamadriz/friendly-snippets",
        },
    })
end)
