require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "dockerfile",
    "go",
    "hcl",
    "json",
    "lua",
    "markdown",
    "python",
    "regex",
    "terraform",
    "yaml",
  },
  highlight = { enable = true, use_languagetree = true },
  indent = { enable = true },
  context_commentstring = { enable = true, enable_autocmd = false },

  refactor = {
    highlight_current_scope = { enable = false },
    highlight_definitions = { enable = true },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gs",
      node_incremental = "gj",
      scope_incremental = "gl",
      node_decremental = "gk",
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
})
