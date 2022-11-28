require("mason").setup({
    providers = {
      "mason.providers.client",
      "mason.providers.registry-api"
  }
})

local capabilities = vim.lsp.protocol.make_client_capabilities() capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = {
    "gopls",
    "terraformls",
    "sumneko_lua",
    "yamlls",
    "jsonls",
    "dockerls",
  }
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      on_attach = function(client, bufnr)
      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
      end
        if server_name == "terraformls" then
          require("treesitter-terraform-doc").setup()
        end
      end
    })
  end
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
