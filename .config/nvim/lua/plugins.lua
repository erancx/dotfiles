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
    use("akinsho/nvim-bufferline.lua")
    use("b3nj5m1n/kommentary")
    use("folke/trouble.nvim")
    use("glepnir/galaxyline.nvim")
    use("windwp/nvim-autopairs")
    use("williamboman/nvim-lsp-installer")
    use("kyazdani42/nvim-web-devicons")
    use("lewis6991/gitsigns.nvim")
    use("lukas-reineke/indent-blankline.nvim")
    use("olimorris/onedarkpro.nvim")
    use("neovim/nvim-lspconfig")
    use("ntpeters/vim-better-whitespace")
    use("nvim-lua/lsp-status.nvim")
    use("ray-x/lsp_signature.nvim")
    use("tpope/vim-fugitive")
    use("wbthomason/packer.nvim")
    use("mfussenegger/nvim-dap")
    use("nvim-telescope/telescope-dap.nvim")
    use("mfussenegger/nvim-dap-python")
    use("theHamsta/nvim-dap-virtual-text")
    use("kyazdani42/nvim-tree.lua")
    use("viebel/halonot")
    use("folke/which-key.nvim")
    use("famiu/bufdelete.nvim")
    use({ "kkoomen/vim-doge", run = ":call doge#install()" })
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
