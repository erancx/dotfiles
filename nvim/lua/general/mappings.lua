local g = vim.g
local api = vim.api

-- Formatter
function run_formatter()
  local filetype = vim.bo.filetype
  local formatters = require("formatter.config").values.filetype[filetype]

  if vim.bo.modifiable then
    if not require("formatter.util").isEmpty(formatters) then
      vim.api.nvim_command("Format")
    else
      vim.lsp.buf.formatting()
    end
  end
end

g.mapleader = ','
api.nvim_set_keymap('n', '<Tab>', '%', { noremap = true })
api.nvim_set_keymap('v', '<Tab>', '%', { noremap = true })
api.nvim_set_keymap('x', '<C-c>', '"+y', { noremap = true })
api.nvim_set_keymap('n', '<C-h>', '<C-W>h', { noremap = true })
api.nvim_set_keymap('n', '<C-j>', '<C-W>j', { noremap = true })
api.nvim_set_keymap('n', '<C-k>', '<C-W>k', { noremap = true })
api.nvim_set_keymap('n', '<C-l>', '<C-W>l', { noremap = true })
api.nvim_set_keymap('n', '<C-d>', ':BufferNext<CR>', { noremap = true })
api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true })
api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files cwd=~/workspace/repo<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>=', '<C-W>=<CR>', { noremap = true })
api.nvim_set_keymap('n', 'Q', '<nop>', { noremap = true })
api.nvim_set_keymap('n', 'q:', '<nop>', { noremap = true })
api.nvim_set_keymap('n', '<Leader>b', ':Telescope buffers<cr>', { noremap = true })
api.nvim_set_keymap('n', '<Leader>l', ':Telescope oldfiles<cr>', { noremap = true })
api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<cr>', { noremap = true })
api.nvim_set_keymap('n', '<Leader>fw', ':Telescope grep_string<cr>', { noremap = true })
api.nvim_set_keymap('n', '<leader>fb', ':Telescope file_browser<CR>', { noremap = true })
api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files hidden=true<cr>', { noremap = true })
api.nvim_set_keymap('n', '<leader>c', ':BufferClose<CR>', { noremap = true })
api.nvim_set_keymap('n', '<esc>', ':nohlsearch<return><esc>', { noremap = true })
api.nvim_set_keymap('n', '<leader>f', '<cmd>lua run_formatter()<CR>', { noremap = true })

-- https://github.com/mjlbach/defaults.nvim/blob/master/init.lua
