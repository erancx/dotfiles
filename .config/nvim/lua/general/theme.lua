require("catppuccin").setup({
    transparent_background = true,
    term_colors = true,
    compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = { "italic" },
        functions = { "italic" },
        keywords = { "italic" },
        strings = {},
        variables = { "italic" },
        numbers = {},
        booleans = { "italic" },
        properties = { "italic" },
        types = { "italic" },
        operators = { "italic" },
    },
})

vim.cmd.colorscheme "catppuccin"
