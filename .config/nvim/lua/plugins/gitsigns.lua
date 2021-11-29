require("gitsigns").setup({
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
        ignore_whitespace = true,
    },
    numhl = true,
    linehl = false,
    keymaps = {
        noremap = true,
        buffer = true,
    },
    watch_gitdir = {
        interval = 1000,
    },
    sign_priority = 6,
    update_debounce = 200,
    status_formatter = nil,
})
