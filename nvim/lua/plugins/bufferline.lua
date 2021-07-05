require('bufferline').setup {
  options = {
    view = "default",
    numbers = "ordinal",
    number_style = "subscript",
    indicator_icon = '▎',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 18,
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "slant",
    always_show_bufferline = true,
    enforce_regular_tabs = false,
  },
  -- tokyonight background
  highlights = {
    fill = {guibg = "#24283b"},
    background = {guibg = "#24283b"},
    indicator_selected = {guibg = "#24283b"},
    separator = {guibg = "#24283b"},
 }
}
