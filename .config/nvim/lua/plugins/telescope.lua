require("telescope").setup({
  defaults = {
    mappings = {
      n = {
        ["<c-d>"] = require("telescope.actions").delete_buffer,
      },
      i = {
        ["?"] = "which_key",
        ["<c-d>"] = require("telescope.actions").delete_buffer,
      },
    },
    prompt_prefix = "   ",
    file_ignore_patterns = {
      ".git/",
      "%.csv",
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
      "%.lock",
      "__pycache__/*",
      "%.sqlite3",
      "%.ipynb",
      "vendor/*",
      "^node_modules/",
      "^deps/",
      "^plugin/packer_compiled.lua",
      "^.next/",
      "^.yarn/",
      "yarn.lock",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    project = {
      base_dirs = { "~/workspace/repo", "~/.dotfiles" },
      hidden_files = true,
    },
  },
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("project")
require("telescope").load_extension("file_browser")
