require('bufferline').setup {
  options = {
    max_name_length = 30,
    max_prefix_length = 20,
    tab_size = 25,
    separator_style = "slant",
  },
  -- tokyonight background
  highlights = {
    fill = {guibg = "#24283b"},
    indicator_selected = {guibg = "#7aa2f7"},
 }
}
