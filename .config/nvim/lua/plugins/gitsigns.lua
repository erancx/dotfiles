require("gitsigns").setup({
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
