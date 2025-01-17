-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- full file path
vim.o.title = true
vim.o.titlelen = 0
vim.o.titlestring = '%{expand("%:p")}'

-- indent line wraps when initial line had indentation
vim.o.breakindent = true

-- search: case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- tf files are always terraform, not "tf" (whatever that is)
vim.filetype.add({
  extension = {
    tf = "terraform",
  },
})

vim.o.relativenumber = false
vim.o.mouse = "v"
