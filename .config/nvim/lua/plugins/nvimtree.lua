local g = vim.g

g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_gitignore = 0
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
g.nvim_tree_root_folder_modifier = table.concat({ ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" })
--
g.nvim_tree_show_icons = {
    folders = 1,
    files = 1,
}

g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        deleted = "",
        ignored = "◌",
        renamed = "➜",
        staged = "✓",
        unmerged = "",
        unstaged = "✗",
        untracked = "★",
    },
    folder = {
        default = "",
        empty = "", -- 
        empty_open = "",
        open = "",
        symlink = "",
        symlink_open = "",
    },
}

require("nvim-tree").setup({
    diagnostics = {
        enable = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    filters = {
        dotfiles = false,
    },
    disable_netrw = true,
    hijack_netrw = true,
    update_to_buf_dir = {
        enable = true,
        auto_open = true,
    },
    ignore_ft_on_setup = { "dashboard" },
    auto_close = false,
    open_on_tab = true,
    hijack_cursor = true,
    nvim_tree_ignore = { ".git", "node_modules", ".cache" },
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = false,
    },
    view = {
        allow_resize = true,
        side = "left",
        width = 25,
    },
})
