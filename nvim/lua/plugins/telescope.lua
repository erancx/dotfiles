require("telescope").setup({
	defaults = {
		prompt_prefix = "   ",
		file_ignore_patterns = { ".git/" },
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = false,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
		},
	},
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("project")
