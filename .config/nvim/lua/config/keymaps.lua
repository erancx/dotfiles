-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local lsp_utils = require("utils.lsp_utils")

-- stylua: ignore start

-- Add a keymap for toggling BasedPyright settings
vim.keymap.set("n", "<leader>ut", function() lsp_utils.toggle_basedpyright_settings() end, { desc = "Toggle BasedPyright Settings" })

vim.keymap.set("n", "<leader>ds", function() require("dap").continue() end, { desc = "Debugger: Start" })
vim.keymap.set("n", "<leader>dpp", function() require("dap").pause() end, { desc = "Debugger: Pause" })
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Debugger: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>do", function() require("dap").step_over() end, { desc = "Debugger: Step Over" })
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, { desc = "Debugger: Step Into" })
vim.keymap.set("n", "<leader>ds", function() require("dap").terminate() end, { desc = "Debugger: Terminate" })
vim.keymap.set("n", "<leader>dS", function() require("dap").step_out() end, { desc = "Debugger: Step Out" })
