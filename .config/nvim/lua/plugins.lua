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
  use("SmiteshP/nvim-navic")
  use("akinsho/nvim-bufferline.lua")
  use("jvirtanen/vim-hcl")
  use("akinsho/nvim-toggleterm.lua")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use("beauwilliams/focus.nvim")
  use("danymat/neogen")
  use("famiu/bufdelete.nvim")
  use("folke/trouble.nvim")
  use("folke/which-key.nvim")
  use("nvim-tree/nvim-tree.lua")
  use("nvim-tree/nvim-web-devicons")
  use("lewis6991/gitsigns.nvim")
  use("catppuccin/nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("neovim/nvim-lspconfig")
  use("norcalli/nvim-colorizer.lua")
  use("ntpeters/vim-better-whitespace")
  use("nvim-lua/lsp-status.nvim")
  use("lewis6991/impatient.nvim")
  use("nvim-lualine/lualine.nvim")
  use("tpope/vim-fugitive")
  use("wbthomason/packer.nvim")
  use("windwp/nvim-autopairs")
  use("sindrets/diffview.nvim")
  use("jjo/vim-cue")
  use("onsails/lspkind-nvim")
  use({
    "echasnovski/mini.move",
    config = function()
      require("mini.move").setup()
    end,
  })
  use({
    "utilyre/barbecue.nvim",
    config = function()
      require("barbecue").setup({})
    end,
  })
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
  })
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  })
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
    run = function()
      vim.fn["mkdp#util#install"]() -- install without yarn or npm
    end,
  })
  -- auto-completion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "saadparwaiz1/cmp_luasnip",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  })
  use({
    "L3MON4D3/LuaSnip",
    requires = {
      "rafamadriz/friendly-snippets",
    },
  })
  -- DAP
  use({
    "mfussenegger/nvim-dap",
    requires = {
      "nvim-telescope/telescope-dap.nvim",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
    },
  })
  use({
    "ldelossa/gh.nvim",
    requires = { { "ldelossa/litee.nvim" } },
  })
end)

require('litee.lib').setup()
require('litee.gh').setup({
  -- deprecated, around for compatability for now.
  jump_mode   = "invoking",
  -- remap the arrow keys to resize any litee.nvim windows.
  map_resize_keys = false,
  -- do not map any keys inside any gh.nvim buffers.
  disable_keymaps = false,
  -- the icon set to use.
  icon_set = "default",
  -- any custom icons to use.
  icon_set_custom = nil,
  -- whether to register the @username and #issue_number omnifunc completion
  -- in buffers which start with .git/
  git_buffer_completion = true,
  -- defines keymaps in gh.nvim buffers.
  keymaps = {
      -- when inside a gh.nvim panel, this key will open a node if it has
      -- any futher functionality. for example, hitting <CR> on a commit node
      -- will open the commit's changed files in a new gh.nvim panel.
      open = "<CR>",
      -- when inside a gh.nvim panel, expand a collapsed node
      expand = "zo",
      -- when inside a gh.nvim panel, collpased and expanded node
      collapse = "zc",
      -- when cursor is over a "#1234" formatted issue or PR, open its details
      -- and comments in a new tab.
      goto_issue = "gd",
      -- show any details about a node, typically, this reveals commit messages
      -- and submitted review bodys.
      details = "d",
      -- inside a convo buffer, submit a comment
      submit_comment = "<C-s>",
      -- inside a convo buffer, when your cursor is ontop of a comment, open
      -- up a set of actions that can be performed.
      actions = "<C-a>",
      -- inside a thread convo buffer, resolve the thread.
      resolve_thread = "<C-r>",
      -- inside a gh.nvim panel, if possible, open the node's web URL in your
      -- browser. useful particularily for digging into external failed CI
      -- checks.
      goto_web = "gx"
  }
})
