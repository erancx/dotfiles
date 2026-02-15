return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- Set the colorscheme for LazyVim
      colorscheme = "catppuccin",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Specify languages to be installed for Treesitter
      ensure_installed = {
        "bash",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "vim",
        "yaml",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        -- Configure pyright server for Python
        pyright = {},
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      -- Ensure installation of specific tools
      ensure_installed = {
        "shellcheck",
        "shfmt",
        "flake8",
        "black",
      },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        sources = {
          projects = {
            -- Use picker for project selection
            confirm = "picker",
          },
          files = {
            -- Include hidden files in the file picker
            hidden = true,
          },
        },
      },
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  },
  {
    "akinsho/bufferline.nvim",
    init = function()
      local bufline = require("catppuccin.groups.integrations.bufferline")
      function bufline.get()
        return bufline.get_theme()
      end
    end,
  },
    {
    "akinsho/bufferline.nvim",
    init = function()
      local bufline = require("catppuccin.special.bufferline")
      function bufline.get()
        return bufline.get_theme()
      end
    end,
  },
}
