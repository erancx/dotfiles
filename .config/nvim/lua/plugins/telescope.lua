require("telescope").setup({
    defaults = {
        layout_strategy = "vertical",
        layout_config = {
            vertical = {
                height = 0.9,
                preview_cutoff = 0,
                preview_height = 0.6,
                results_height = 0.3,
                width = 0.7,
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
require("telescope").load_extension("file_browser")
require("telescope").load_extension("dap")
