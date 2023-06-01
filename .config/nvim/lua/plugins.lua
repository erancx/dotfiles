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

local opt = {
  defaults = {
    lazy = false,
    version = nil,
  },
  spec = nil,
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  ui = {
    wrap = true,
    border = "single",
  },
  checker = {
    enabled = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
    cache = {
      enabled = true,
    },
    reset_packpath = true,
  },
}

local plugins = {
  { "catppuccin/nvim", lazy = true, priority = 1000 },
  { "SmiteshP/nvim-navic", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "norcalli/nvim-colorizer.lua", event = "VeryLazy" },
  { "tpope/vim-fugitive" },
  { "sindrets/diffview.nvim", event = "VeryLazy" },
  { "jjo/vim-cue" },
  { "onsails/lspkind-nvim" },
  { "iamcco/markdown-preview.nvim" },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      lazy = true,
    },
    config = function()
      require("plugins.gitsigns")
    end,
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
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
    event = "VeryLazy",
    keys = { "gcc", "gbc", "gc" },
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gza", -- Add surrounding in Normal and Visual modes
        delete = "gzd", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "gzr", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-project.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("plugins.telescope")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("plugins.cmp")
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.notify")
    end,
  },
  {
    "akinsho/nvim-bufferline.lua",
    lazy = false,
    config = function()
      require("plugins.bufferline")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
      require("plugins.lualine")
    end,
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        enabled = true,
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugins.indent_blank_line")
    end,
  },
  {
    "beauwilliams/focus.nvim",
    config = function()
      require("plugins.focus")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = false,
    config = function()
      require("plugins.nvimtree")
    end,
  },
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.trouble")
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.whichkey")
    end,
  },
  {
    "akinsho/nvim-toggleterm.lua",
    config = function()
      require("plugins.toggleterm")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.lsp")
    end,
    dependencies = {
      {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        config = function()
          require("plugins.lsp.null-ls")
        end,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "echasnovski/mini.bufremove",
    version = false,
    config = function()
      require("mini.bufremove").setup()
    end,
    keys = {
      {
        "<S-x>",
        function()
          require("mini.bufremove").delete(n, true)
        end,
        desc = "Delete Buffer",
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = true },
        panel = { enabled = true },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup()
    end,
  },
}

require("lazy").setup(plugins, opt)
