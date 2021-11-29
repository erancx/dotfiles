local vim = vim
local lsp = require("lspconfig")
local null_ls = require("plugins.lsp.null-ls")
require("plugins.lsp.globals")

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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
    update_in_insert = true,
    virtual_text = {
        true,
        spacing = 6,
    },
})

local function on_attach()
    require("lsp_signature").on_attach()
end

local lsp_installer = require("nvim-lsp-installer")

local on_attach = function(client, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

lsp_installer.on_server_ready(function(server)
    local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }

    server:setup(opts)
    vim.cmd([[ do User LspAttachBuffers ]])
    local signs = { Error = " 🞮", Warn = " ▲", Hint = " ", Info = " " }

    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
end)

lsp.terraformls.setup({
    on_attach = on_attach,
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform" },
})

null_ls.setup(on_attach)
