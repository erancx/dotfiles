local api = vim.api

local function nvim_create_augroup(group_name, definitions)
  api.nvim_command('augroup ' .. group_name)
  api.nvim_command('autocmd!')
  for _, def in ipairs(definitions) do
    local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
    api.nvim_command(command)
  end
  api.nvim_command('augroup END')
end


local definitions = {
  wins = {
    { 'VimResized', '*', 'wincmd =' },
    { 'BufWinEnter', '*', 'highlight ExtraWhitespace guifg=#666666' },
    { 'BufWinEnter', '*', [[match ExtraWhitespace /\s\+$/]] },
  };
}

nvim_create_augroup('autocmd', definitions)



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
