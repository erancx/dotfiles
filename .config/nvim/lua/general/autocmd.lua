local exec = vim.api.nvim_exec -- execute Vimscript
local cmd = vim.cmd -- execute Vim commands

-- 2 spaces for selected filetypes
cmd([[ autocmd FileType xml,html,xhtml,css,scssjavascript,lua,dart setlocal shiftwidth=2 tabstop=2 ]])

-- json
cmd([[ au BufEnter *.json set ai expandtab shiftwidth=2 tabstop=2 sta fo=croql ]])

-- don't auto commenting new lines
cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])

-- remove whitespace on save
cmd([[au BufWritePre * :%s/\s\+$//e]])

-- jump to the last position when reopening a file
cmd([[
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
]])

-- highlight on yank
exec(
    [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500, on_visual=true}
  augroup end
]],
    false
)

-- yaml configurations
vim.cmd([[
augroup yaml
  autocmd!
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
augroup END
]])

-- json configurations
vim.cmd([[
augroup yaml
  autocmd!
  autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
augroup END
]])

-- term configurations
vim.cmd([[
augroup term
  autocmd!
  au TermOpen * setlocal listchars= nonumber norelativenumber signcolumn=no
  au TermOpen * startinsert
  au BufEnter,BufWinEnter,WinEnter term://* startinsert
  au BufLeave term://* stopinsert
augroup END
]])

-- go configurations
vim.cmd([[
augroup golang
  autocmd!
  au FileType go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
augroup END
]])
