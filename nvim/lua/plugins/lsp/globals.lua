vim.g.lsp_config = {
    lua = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        },
    },
}

vim.g.coq_settings = {
    auto_start = "shut-up",
    keymap = {
        jump_to_mark = "<c-q>",
    },
    clients = {
        tabnine = {
            enabled = true,
        },
    },
}
