local colors = require("onedark.colors").setup()

require('bufferline').setup {
  options = {
    numbers = "ordinal",
    number_style = "subscript",
    max_name_length = 30,
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = {"", ""},
    max_prefix_length = 20,
    tab_size = 25,
    always_show_bufferline = true,
    separator_style = "thick",
  },
  -- tokyonight background
  highlights = {
    fill = {guibg = colors.bg},
    background = {guibg = colors.bg},
    buffer_selected = {guibg = colors.bg_highlight, guifg = colors.orange},
  }
}
