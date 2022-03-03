vim.g.material_style = "darker"

require("material").setup({

    contrast = {
        sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = true, -- Enable contrast for floating windows
        line_numbers = true, -- Enable contrast background for line numbers
        sign_column = true, -- Enable contrast background for the sign column
        cursor_line = true, -- Enable darker background for the cursor line
        non_current_windows = true, -- Enable darker background for non-current windows
        popup_menu = true, -- Enable lighter background for the popup menu
    },

    italics = {
        comments = true, -- Enable italic comments
        keywords = true, -- Enable italic keywords
        functions = true, -- Enable italic functions
        strings = true, -- Enable italic strings
        variables = true, -- Enable italic variables
    },

    contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
        "terminal", -- Darker terminal background
        "packer", -- Darker packer background
        "qf", -- Darker qf list background
    },

    high_visibility = {
        darker = true, -- Enable higher contrast text for darker style
    },

    disable = {
        borders = true, -- Disable borders between vertically split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false, -- Hide the end-of-buffer lines
    },

    lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asynchronously for faster startup (turned on by default)
})

vim.cmd("colorscheme material")
