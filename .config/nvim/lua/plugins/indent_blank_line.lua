require("indent_blankline").setup({
    char = "│",
    use_treesitter = true,
    show_foldtext = true,
    show_current_context = true, -- Expand indentlines down to the end of a method for example
    show_first_indent_level = true, -- Hide indentline for the first column
    show_trailing_blankline_indent = false, -- Hide show indentline on blanklines
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
        "aerial",
        "alpha",
        "help",
        "gitcommit",
        "dashboard",
        "NvimTree",
        "packer",
        "lspinfo",
        "Startify",
        "TelescopePrompt",
        "TelescopeResults",
        "Trouble",
        "undotree",
    },
})
