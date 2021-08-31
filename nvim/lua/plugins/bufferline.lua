local colors = require("onedark.colors").setup()

require('bufferline').setup {
  options = {
    max_name_length = 30,
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = {"", ""},
    max_prefix_length = 20,
    tab_size = 25,
    always_show_bufferline = true,
    show_tab_indicators = false,
    separator_style = "thick",
    custom_filter = function(buf_number)
       local present_type, type = pcall(function()
          return vim.api.nvim_buf_get_var(buf_number, "term_type")
       end)

       if present_type then
          if type == "vert" then
             return false
          elseif type == "hori" then
             return false
          else
             return true
          end
       else
          return true
       end
    end,
  },
  highlights = {
    fill = {guibg = colors.bg},
    background = {guibg = colors.bg},
    buffer_selected = {guibg = colors.bg_highlight, guifg = colors.orange},
  }
}
