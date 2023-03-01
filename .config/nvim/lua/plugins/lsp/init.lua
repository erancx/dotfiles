local LSP_SERVERS = {
    "ansiblels",
    "awk_ls",
    "bashls",
    "dagger",
    "dockerls",
    "gopls",
    "jsonls",
    "marksman",
    "pyright",
    "terraformls",
    "yamlls",
}

require("mason").setup({
    providers = {
        "mason.providers.client",
        "mason.providers.registry-api",
    },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
local mason_lspconfig = require("mason-lspconfig")

-- The first entry (without a key) will be the default handler
-- and will be called for each installed server that doesn't have
-- a dedicated handler.
-- :h mason-lspconfig-automatic-server-setup
mason_lspconfig.setup({
    ensure_installed = LSP_SERVERS,
})

mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            on_attach = function(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    require("nvim-navic").attach(client, bufnr)
                end
            end,
        })
    end,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
