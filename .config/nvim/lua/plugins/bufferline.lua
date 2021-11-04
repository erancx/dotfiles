local colors = require("onedark.colors").setup()

require("bufferline").setup({
    options = {
        offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
        max_name_length = 30,
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        separator_style = { "", "" },
        always_show_bufferline = true,
        show_tab_indicators = false,
    },
    highlights = {
        buffer_selected = { guibg = colors.bg_highlight, guifg = "#61AFEF" },
    },
})
