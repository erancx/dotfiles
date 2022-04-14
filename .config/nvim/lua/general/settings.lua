local exec = vim.api.nvim_exec
local set  = vim.opt
local cmd  = vim.cmd

-- set python interpreter
vim.g.python3_host_prog = "~/workspace/venv/default3/bin/python"

-- copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

set.autoindent      = true     -- maintain indent of current line
set.backspace       = 'indent,start,eol' -- make backspace behave like normal again
set.completeopt     = 'menuone,noselect,noinsert' -- completion options
set.cursorline      = true 	   -- highlight current line
set.expandtab       = true     -- expand tabs into spaces
set.hidden          = true     -- allows you to hide buffers with unsaved changes without being prompted
set.hlsearch        = true 	   -- highlighted search results
set.ignorecase      = true 	   -- ignore case sensetive while searching
set.inccommand      = 'split'  -- live preview of :s results
set.incsearch       = true 	   -- incremental search
set.laststatus      = 2        -- always show status line
set.lazyredraw      = true -- faster scrolling
set.list            = false    -- show whitespace
set.number          = true     -- show line numbers
set.scrolloff       = 1        -- when scrolling, keep cursor 1 lines away from screen border
set.shell           = 'zsh'    -- shell to use for `!`, `:!`, `system()` etc.
set.shiftround      = true
set.shiftwidth      = 2        -- spaces per tab (when shifting), when using the >> or << commands, shift lines by 4 spaces
set.showmatch       = true 	   -- show the matching part of the pair for [] {} and ()
set.sidescrolloff   = 2        -- keep 30 columns visible left and right of the cursor at all times
set.smartcase       = true
set.smarttab        = true     -- <tab>/<BS> indent/dedent in leading whitespace
set.softtabstop     = 2
set.splitbelow      = true      -- open horizontal splits below current window
set.splitright      = true      -- open vertical splits to the right of the current window
set.tabstop         = 2         -- spaces per tab
set.termguicolors   = true      -- Enable GUI colors for the terminal to get truecolor
set.undodir         = os.getenv("HOME") .. "/.vim" -- vim.options do not expand "~"
set.undofile        = true
set.updatetime      = 250              -- CursorHold interval
set.wildignore      = set.wildignore + '*/tmp/*,*.so,*.swp,*.zip,*.rpm,*.o,*.obj,.git,*.rbc,*.pyc,__pycache__' -- patterns to ignore during file-navigation
set.laststatus = 3
set.wildmode = "longest:full,full" set.wrap            = false         -- don't automatically wrap on load
set.shortmess:append "sI"
set.listchars = {
         nbsp       = '⦸',      -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
         extends    = '»',      -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
         precedes   = '«',      -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
         tab        = '▷─',     -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
         trail      = '•',      -- BULLET (U+2022, UTF-8: E2 80 A2)
         space      = ' ',
}
set.fillchars = {
        diff        = '∙',      -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
        eob         = ' ',      -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
        fold        = '·',      -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
        vert        = ' ',      -- remove ugly vertical lines on window division
}
--set.colorcolumn = "79"        -- vertical word limit line

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
