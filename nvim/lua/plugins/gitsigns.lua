  require'gitsigns'.setup{
    signs = {
      add          = { hl = 'GitGutterAdd', text = '▋' },
      change       = { hl = 'GitGutterChange', text = '▋' },
      delete       = { hl = 'GitGutterDelete', text = '▋' },
      topdelete    = { hl = 'GitGutterDeleteChange', text = '▔' },
      changedelete = { hl = 'GitGutterChange', text = '▎' },
    },
      numhl = true,
      linehl = false,
      keymaps = {
        noremap = true,
        buffer = true,
      },
      watch_index = {
        interval = 1000
      },
      sign_priority = 6,
      update_debounce = 200,
      status_formatter = nil,
  }
