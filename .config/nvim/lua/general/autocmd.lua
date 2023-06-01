local exec = vim.api.nvim_exec -- execute Vimscript
local cmd = vim.cmd -- execute Vim commands

vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  augroup end
  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end
]])

-- 2 spaces for selected filetypes
cmd([[ autocmd FileType json,yaml,xml,html,xhtml,css,scssjavascript,lua,dart setlocal shiftwidth=2 tabstop=2 expandtab ]])

-- highlight on yank
exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=200, on_visual=true}
  augroup end
]],
  false
)

-- go configurations
cmd([[
augroup golang
  autocmd!
  au FileType go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
augroup END
]])

cmd([[
augroup git
  autocmd!
  autocmd FileType gitcommit setlocal wrap
  autocmd FileType gitcommit setlocal spell
augroup END
]])

cmd([[
augroup markdown
  autocmd!
  autocmd FileType markdown setlocal wrap
  autocmd FileType markdown setlocal spell
augroup END
]])

cmd([[
  hi TrailingWhitespace ctermbg=red guibg=red
  call matchadd("TrailingWhitespace", '\v\s+$')
]])
