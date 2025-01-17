local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- On neogit event, update neotree git status
local group = vim.api.nvim_create_augroup("MyCustomNeogitEvents", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "NeogitStatusRefreshed",
  group = group,
  callback = function()
    require("neo-tree.sources.manager").refresh("filesystem")
  end,
})
