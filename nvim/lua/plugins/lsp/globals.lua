vim.g.lsp_config = {
  lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },
}

vim.g.coq_settings = {
  auto_start = true,
  clients = {
    tabnine = {
      enabled = true,
    },
  },
}
