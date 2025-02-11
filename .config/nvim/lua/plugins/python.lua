local prefix = "<Leader>cI"

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              inlayHints = {
                variableTypes = false,
                functionReturnTypes = false,
                callArgumentNames = false,
              },
            },
          },
        },
      }
    end,
  },
  {
    "geg2102/nvim-python-repl",
    lazy = true,
    dependencies = {
      "nvim-treesitter",
    },
    keys = {
      {
        prefix,
        "",
        desc = "iPython Terminal",
      },
      {
        prefix .. "r",
        function()
          require("nvim-python-repl").send_statement_definition()
        end,
        desc = "Send to ipython terminal",
        mode = "n",
      },
      {
        "<Leader>r",
        function()
          require("nvim-python-repl").send_statement_definition()
        end,
        desc = "Send to ipython terminal",
        mode = "n",
      },
      {
        prefix .. "b",
        function()
          require("nvim-python-repl").send_buffer_to_repl()
        end,
        desc = "Send entire buffer to REPL",
        mode = "n",
      },
      {
        prefix .. "E",
        function()
          require("nvim-python-repl").toggle_execute()
          vim.notify(
            "Automatic REPL execution "
              .. (require("nvim-python-repl.config").defaults["execute_on_send"] and "Enabled" or "Disabled")
          )
        end,
        desc = "Toggle automatic execution",
        mode = "n",
      },
      {
        prefix .. "V",
        function()
          require("nvim-python-repl").toggle_vertical()
          vim.notify(
            "REPL split set to "
              .. (require("nvim-python-repl.config").defaults["vsplit"] and "Vertical" or "Horizontal")
          )
        end,
        desc = "Toggle vertical/horizontal split",
        mode = "n",
      },
      -- Visual mode keymaps
      {
        "<Leader>r",
        function()
          require("nvim-python-repl").send_visual_to_repl()
        end,
        desc = "Send to ipython terminal",
        mode = "v",
      },
    },
    ft = { "python", "lua" },
    config = function()
      require("nvim-python-repl").setup({
        execute_on_send = true,
        vsplit = true,
        spawn_command = {
          python = "ipython",
          lua = "ilua",
        },
      })
    end,
  },
}
