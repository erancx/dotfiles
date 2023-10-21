require("catppuccin").setup({
  transparent_background = false,
  term_colors = true,
  compile = {
    enabled = true,
    path = vim.fn.stdpath("cache") .. "/catppuccin",
  },
})

vim.cmd.colorscheme("catppuccin")
