local lspconfig = require('lspconfig')
local lspinstall = require("lsp-status")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
   },
}

-- lspInstall + lspconfig stuff
local servers = { "yamlls", "bashls", "vimls", "jsonls", "dockerls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {on_attach = on_attach, capabilities = capabilities}
end

lspconfig.efm.setup {
  filetypes = {"yaml", "python", "sh", "json", "markdown"},
  capabilities = capabilities,
  init_options = {documentFormatting = true},
  cmd = {
    "efm-langserver",
    "-c",
    vim.fn.stdpath("config") .. "/lua/plugins/efm.yml"
  },
  root_dir = function()
    return vim.fn.getcwd()
  end
}


lspconfig.pyright.setup {
    root_dir = lspconfig.util.root_pattern('.git', vim.fn.getcwd()),
    capabilities = capabilities,
    on_attach = function(client)
        require'lsp_signature'.on_attach()
    end,
}

lspconfig.gopls.setup {
    capabilities = capabilities,
    on_attach = function(client)
        require'lsp_signature'.on_attach()
    end,
}

lspconfig.terraformls.setup {
    on_attach = on_attach_common,
    capabilities = capabilities,
    cmd = {"terraform-ls", "serve"},
    filetypes = {"tf"}
}

lspconfig.jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {"vscode-json-languageserver", "--stdio"}
}

-- replace the default lsp diagnostic symbols
local function lspSymbol(name, icon)
   vim.fn.sign_define("LspDiagnosticsSign" .. name, { text = icon, numhl = "LspDiagnosticsDefaul" .. name })
end

lspSymbol("Error", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")
lspSymbol("Warning", "")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
   virtual_text = {
      prefix = "",
      spacing = 0,
   },
   signs = true,
   underline = true,
   update_in_insert = false, -- update diagnostics insert mode
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
   border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
   border = "single",
})
