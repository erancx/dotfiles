local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute 'packadd packer.nvim'
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)
  use 'David-Kunz/treesitter-unit'
  use 'akinsho/nvim-bufferline.lua'
  use 'b3nj5m1n/kommentary'
  use 'glepnir/galaxyline.nvim'
  use 'jiangmiao/auto-pairs'
  use 'kabouzeid/nvim-lspinstall'
  use 'kyazdani42/nvim-web-devicons'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'mhartington/formatter.nvim'
  use 'monsonjeremy/onedark.nvim'
  use 'neovim/nvim-lspconfig'
  use 'ntpeters/vim-better-whitespace'
  use 'nvim-lua/lsp-status.nvim'
  use 'ray-x/lsp_signature.nvim'
  use 'tpope/vim-fugitive'
  use 'wbthomason/packer.nvim'
  use {'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons'}
  use {'kkoomen/vim-doge', run = ':call doge#install()'}
  use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}
  use {'ms-jpq/coq_nvim', branch = 'coq'}
  use {'ms-jpq/coq.artifacts', branch= 'artifacts'}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
      {'nvim-telescope/telescope-project.nvim'},
    }
  }
end)
