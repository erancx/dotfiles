local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then
        vim.cmd("packadd " .. plugin)
    end
    return ok, err, code
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim'}
  use {
    'iamcco/markdown-preview.nvim', run = function() vim.fn['mkdp#util#install']() end
  }
  use {
    'kkoomen/vim-doge',
    run = ':call doge#install()'
  }
  use 'b3nj5m1n/kommentary'
  use {
  'hrsh7th/nvim-compe',
  requires = {
            {'hrsh7th/vim-vsnip'},
            {'hrsh7th/vim-vsnip-integ'},
            {'rafamadriz/friendly-snippets'}
        }
  }
  use 'romgrk/barbar.nvim'
  use 'glepnir/galaxyline.nvim'
  use 'jiangmiao/auto-pairs'
  use 'kyazdani42/nvim-web-devicons'
  use 'martinda/Jenkinsfile-vim-syntax'
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'
  use 'ntpeters/vim-better-whitespace'
  use 'psf/black'
  use 'folke/tokyonight.nvim'
  use 'nvim-lua/lsp-status.nvim'
  use 'nvim-lua/diagnostic-nvim'
  use 'windwp/nvim-autopairs'
  use 'sindrets/diffview.nvim'
  use 'tpope/vim-fugitive'
  use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
end)
