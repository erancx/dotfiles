local cmd = vim.cmd

-- colorscheme
require("onedark").setup({
	functionStyle = "italic",
})

-- General settings
cmd("set autoindent")
cmd("set autowrite")
cmd("set backspace=indent,eol,start")
cmd("set cc=120")
cmd("set cmdheight=1")
cmd("set completeopt=menuone,noinsert,noselect")
cmd("set cpoptions+=$")
cmd("set cursorcolumn")
cmd("set cursorline")
cmd("set encoding=UTF-8")
cmd("set inccommand=nosplit")
cmd("set expandtab")
cmd("set fileencoding=utf-8")
cmd("set foldlevel=99")
cmd("set foldmethod=marker")
cmd("set foldmethod=syntax")
cmd("set guicursor=i-c-ci:ver25,o-v-ve:hor20,cr-sm-n-r:block")
cmd("set hidden")
cmd("set hlsearch")
cmd("set ignorecase smartcase")
cmd("set incsearch")
cmd("set laststatus=2")
cmd("set lazyredraw")
cmd("set list")
cmd("set matchpairs+=<:>")
cmd("set modelines=0")
cmd("set mouse=v")
cmd("set nocompatible")
cmd("set noerrorbells")
cmd("set nofoldenable")
cmd("set noshowmode")
cmd("set number")
cmd("set noswapfile")
cmd("set pastetoggle=<C-k>")
cmd("set scrolloff=5")
cmd("set shell=bash")
cmd("set shiftwidth=4")
cmd("set shortmess=aIc")
cmd("set showcmd")
cmd("set showmatch")
cmd("set signcolumn=yes")
cmd("set smartcase")
cmd("set smartindent")
cmd("set smarttab")
cmd("set softtabstop=4")
cmd("set splitbelow")
cmd("set splitright")
cmd("set statusline+=%F")
cmd("set tabstop=4")
cmd("set termguicolors")
cmd("set textwidth=0")
cmd("set ttyfast")
cmd("set undodir=~/.vim/undodir")
cmd("set undofile")
cmd("set updatetime=250")
cmd("set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.rpm,*.o,*.obj,.git,*.rbc,*.pyc,__pycache__")
cmd("set wildoptions=pum")
cmd("set wrap")
cmd("syntax enable")
cmd("syntax on")

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
