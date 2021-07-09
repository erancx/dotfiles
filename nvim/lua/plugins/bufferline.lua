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
    max_name_length = 30,
    max_prefix_length = 20,
    tab_size = 25,
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "thin",
    always_show_bufferline = true,
    enforce_regular_tabs = false,
  },
  -- tokyonight background
  highlights = {
    fill = {guibg = "#24283b"},
    indicator_selected = {guibg = "#7aa2f7"},
 }
}
