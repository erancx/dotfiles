-- Telescope
require('telescope').setup{
    defaults = {
        prompt_prefix = "   ",
        file_ignore_patterns = {".git/"},
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            },
        }
    }
}
require("telescope").load_extension("fzf")
require("telescope").load_extension("project")
