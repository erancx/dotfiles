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
  { "catppuccin/nvim",             lazy = true,       priority = 1000 },
  { "SmiteshP/nvim-navic",         lazy = true },
  { "tpope/vim-fugitive" },
  { "sindrets/diffview.nvim",      event = "VeryLazy" },
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
      require("nvim-autopairs").setup({
        enable_check_bracket_line = true,
        disable_filetype = { "TelescopePrompt", "vim" },
        enable_afterquote = false,
        enable_moveright = true,
      })
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
        { opts.mappings.add,            desc = "Add surrounding",                     mode = { "n", "v" } },
        { opts.mappings.delete,         desc = "Delete surrounding" },
        { opts.mappings.find,           desc = "Find right surrounding" },
        { opts.mappings.find_left,      desc = "Find left surrounding" },
        { opts.mappings.highlight,      desc = "Highlight surrounding" },
        { opts.mappings.replace,        desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gza",            -- Add surrounding in Normal and Visual modes
        delete = "gzd",         -- Delete surrounding
        find = "gzf",           -- Find surrounding (to the right)
        find_left = "gzF",      -- Find surrounding (to the left)
        highlight = "gzh",      -- Highlight surrounding
        replace = "gzr",        -- Replace surrounding
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
      "onsails/lspkind-nvim",
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
      require("notify").setup({
        stages = "slide",
      })
    end,
  },
  {
    "akinsho/nvim-bufferline.lua",
    lazy = false,
    config = function()
      require("bufferline").setup({
        options = {
          modified_icon = "●",
          offsets = { { filetype = "NeoTree", text = "" } },
          show_tab_indicators = false,
          show_close_icon = false,
        },
      })
    end,
    opts = function()
      local Offset = require("bufferline.offset")
      if not Offset.edgy then
        local get = Offset.get
        Offset.get = function()
          if package.loaded.edgy then
            local layout = require("edgy.config").layout
            local ret = { left = "", left_size = 0, right = "", right_size = 0 }
            for _, pos in ipairs({ "left", "right" }) do
              local sb = layout[pos]
              if sb and #sb.wins > 0 then
                local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
                ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#│%*"
                ret[pos .. "_size"] = sb.bounds.width
              end
            end
            ret.total_size = ret.left_size + ret.right_size
            if ret.total_size > 0 then
              return ret
            end
          end
          return get()
        end
        Offset.edgy = true
      end
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
      require("indent_blankline").setup({
        show_end_of_line = true,
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        colored_indent_levels = true,
        use_treesitter = true,
      })
    end,
  },
  {
    "beauwilliams/focus.nvim",
    version = false,
    config = function()
      require("focus").setup({
        autoresize = { enable = false },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    config = function()
      require("trouble").setup({
        mode = "document_diagnostics",
        use_diagnostic_signs = true,
      })
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
      require("toggleterm").setup({})

      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
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
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          accept = false,
        },
      })
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on("menu_opened", function()
          vim.b.copilot_suggestion_hidden = true
        end)

        cmp.event:on("menu_closed", function()
          vim.b.copilot_suggestion_hidden = false
        end)
      end
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      follow_current_file = { enabled = true },
      sources = { "filesystem", "git_status" },
      default_component_configs = {
        git_status = {
          symbols = {
            added = "",
            modified = "",
            deleted = "⊖",
            renamed = "➜",
            untracked = "★",
            ignored = "◌",
            unstaged = "✗",
            staged = "✓",
            conflict = "",
          },
        },
      },
      source_selector = {
        content_layout = "center",
        winbar = true,
        enable = true,
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
      bottom = {
        {
          ft = "toggleterm",
          size = { height = 0.4 },
          -- exclude floating windows
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        "Trouble",
        { ft = "qf",            title = "QuickFix" },
        {
          ft = "help",
          size = { height = 20 },
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
        { ft = "spectre_panel", size = { height = 0.4 } },
      },
      left = {
        {
          title = "Explorer",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
        },
        {
          title = "Git",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "git_status"
          end,
          pinned = true,
          open = "Neotree position=right git_status",
        },
        "neo-tree",
      },
    },
  },
}

require("lazy").setup(plugins, opt)
vim.opt.splitkeep = "screen"
vim.opt.laststatus = 3
