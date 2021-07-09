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
api.nvim_set_keymap('n', '<TAB>', ':BufferLineCycleNext<CR>', { noremap = true })
api.nvim_set_keymap('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', { noremap = true })
api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true })
api.nvim_set_keymap('n', '<C-p>', ':Telescope find_files cwd=~/workspace/repo<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>=', '<C-W>=<CR>', { noremap = true })
api.nvim_set_keymap('n', 'Q', '<nop>', { noremap = true })
api.nvim_set_keymap('n', 'q:', '<nop>', { noremap = true })
api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<cr>', { noremap = true })
api.nvim_set_keymap('n', '<leader>l', ':Telescope oldfiles<cr>', { noremap = true })
api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep<cr>', { noremap = true })
api.nvim_set_keymap('n', '<leader>fw', ':Telescope grep_string<cr>', { noremap = true })
api.nvim_set_keymap('n', '<leader>fb', ':Telescope file_browser<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files hidden=true<cr>', { noremap = true })
api.nvim_set_keymap('n', '<leader>ft', ':Telescope filetypes<cr>', { noremap = true })
api.nvim_set_keymap( 'n', '<leader>fp', ":lua require'telescope'.extensions.project.project{}<CR>", {noremap = true, silent = true})
api.nvim_set_keymap('n', '<S-x>', ':bd!<cr>', { noremap = true })
api.nvim_set_keymap('n', '<esc>', ':nohlsearch<return><esc>', { noremap = true })
api.nvim_set_keymap('n', '<leader>f', ':lua run_formatter()<CR>', { noremap = true })
api.nvim_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', { noremap = true })
api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true })
api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', { noremap = true })
api.nvim_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true })
api.nvim_set_keymap('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>wa', ':lua vim.lsp.buf.add_workspace_folder()<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>wr', ':lua vim.lsp.buf.remove_workspace_folder()<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>wl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>D', ':lua vim.lsp.buf.type_definition()<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true })
api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>q', ':lua vim.lsp.diagnostic.set_loclist()<CR>', { noremap = true })
-- https://github.com/mjlbach/defaults.nvim/blob/master/init.lua
