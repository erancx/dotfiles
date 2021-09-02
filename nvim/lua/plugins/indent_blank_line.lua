vim.g.indent_blankline_char             = '▏'
vim.g.indent_blankline_filetype_exclude = {
  'NvimTree',
  'git',
  'help',
  'lspinfo',
  'markdown',
  'packer',
  'startify',
  'tex',
  'txt',
}
vim.g.indent_blankline_buftype_exclude = {'terminal'}
vim.g.indent_blankline_context_patterns = {
  'class',
  'funtion',
  'method',
  '^if',
  'while',
  'for',
  'with',
  'func_literal',
  'block',
  'try',
  'except',
  'argument_list',
  'object',
  'dictionary'
}
vim.g.indent_blankline_show_current_context           = true
vim.g.indent_blankline_show_first_indent_level        = false
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_space_char_blankline           = '·'
vim.g.indent_blankline_use_treesitter                 = true
