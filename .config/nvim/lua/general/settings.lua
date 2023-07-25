-- set python interpreter
vim.g.python3_host_prog = "~/workspace/venv/default3/bin/python"

-- settings
vim.o.autoindent = true -- maintain indent of current line
vim.o.backspace = "indent,start,eol" -- make backspace behave like normal again
vim.o.completevim = "menuone,noselect,noinsert" -- completion vim.oions
vim.o.cursorline = true -- highlight current line
vim.o.expandtab = true -- expand tabs into spaces
vim.o.hidden = true -- allows you to hide buffers with unsaved changes without being prompted
vim.o.hlsearch = true -- highlighted search results
vim.o.ignorecase = true -- ignore case sensetive while searching
vim.o.inccommand = "split" -- live preview of :s results
vim.o.incsearch = true -- incremental search
vim.o.lazyredraw = true -- faster scrolling
vim.o.list = false -- show whitespace
vim.o.number = true -- show line numbers
vim.o.scrolloff = 1 -- when scrolling, keep cursor 1 lines away from screen border
vim.o.shell = "zsh" -- shell to use for `!`, `:!`, `system()` etc.
vim.o.shiftround = true
vim.o.shiftwidth = 2 -- spaces per tab (when shifting), when using the >> or << commands, shift lines by 4 spaces
vim.o.showmatch = true -- show the matching part of the pair for [] {} and ()
vim.o.sidescrolloff = 2 -- keep 30 columns visible left and right of the cursor at all times
vim.o.smartcase = true
vim.o.smarttab = true -- <tab>/<BS> indent/dedent in leading whitespace
vim.o.softtabstop = 2
vim.o.splitbelow = true -- open horizontal splits below current window
vim.o.splitkeep = "screen"
vim.o.splitright = true -- open vertical splits to the right of the current window
vim.o.tabstop = 2 -- spaces per tab
vim.o.termguicolors = true -- Enable GUI colors for the terminal to get truecolor
vim.o.undodir = os.getenv("HOME") .. "/.vim" -- vim.options do not expand "~"
vim.o.undofile = true
vim.o.updatetime = 250 -- CursorHold interval
vim.o.ls = 0 -- Hide statusline by setting laststatus and cmdheight to 0.
vim.o.ch = 0 -- cmdheight to 0
vim.o.laststatus = 3
vim.o.mouse = "v"

vim.opt.wildmode:append({ "longest:full,full" })
vim.opt.wildignore:append({ "*/tmp/*,*.so,*.swp,*.zip,*.rpm,*.o,*.obj,.git,*.rbc,*.pyc,__pycache__" }) -- patterns to ignore during file-navigation

local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
