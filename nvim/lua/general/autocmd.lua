local api = vim.api

ToggleMouse = function()
  if vim.o.mouse == 'a' then
    vim.wo.signcolumn='no'
    vim.o.mouse = 'v'
    vim.wo.number = false
  else
    vim.wo.signcolumn='yes'
    vim.o.mouse = 'a'
    vim.wo.number = true
  end
end

vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua ToggleMouse()<cr>', { noremap = true })

-- Highlight on yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)
