-- Plugins
pcall(require, "impatient")

require("plugins")

-- General
require("general.theme")
require("general.autocmd")
require("general.mappings")
require("general.settings")

-- Plugins configs
require("plugins.autopairs")
require("plugins.bufferline")
require("plugins.cmp")
require("plugins.copilot")
require("plugins.lualine")
require("plugins.gitsigns")
require("plugins.neogen")
require("plugins.indent_blank_line")
require("plugins.focus")
require("plugins.comment")
require("plugins.lsp")
require("plugins.lsp.null-ls")
require("plugins.mason")
require("plugins.nvimtree")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.trouble")
require("plugins.whichkey")
require("plugins.toggleterm")
require("plugins.dap")
