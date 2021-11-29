require("telescope").setup({
    defaults = {
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
            "node_modules/*",
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = false,
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
require("telescope").load_extension("dap")
