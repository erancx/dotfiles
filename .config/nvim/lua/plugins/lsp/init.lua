local LSP_SERVERS = {
  "ansiblels",
  "awk_ls",
  "bashls",
  "dockerls",
  "grammarly",
  "marksman",
  "gopls",
  "jsonls",
  "pyright",
  "yamlls",
  "lua_ls",
  "terraformls",
  "jsonls",
}

require("mason").setup({
  providers = {
    "mason.providers.client",
    "mason.providers.registry-api",
  },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local mason_lspconfig = require("mason-lspconfig")

-- The first entry (without a key) will be the default handler
-- and will be called for each installed server that doesn't have
-- a dedicated handler.
-- :h mason-lspconfig-automatic-server-setup
mason_lspconfig.setup({
  ensure_installed = LSP_SERVERS,
})

local lspSettings = {}
local lspFileTypes = {}

lspSettings.lua_ls = {
  settings = {
    Lua = {
      format = { enable = true },
      completion = {
        callSnippet = "Replace",
        keywordSnippet = "Replace",
        displayContext = 2,
        postfix = ".",
      },
      diagnostics = {
        globals = { "vim" },
        disable = { "trailing-space" },
      },
      hint = {
        enable = true,
        setType = true,
        paramName = "All",
        paramType = true,
        arrayIndex = "Disable",
      },
      telemetry = { enable = false },
    },
  },
}

lspSettings.jsonls = {
  json = {
    validate = { enable = true },
    format = { enable = true },
  },
}

lspSettings.yamlls = {
  yaml = { keyOrdering = false }, -- FIX mapKeyOrder
  schemas = {
    ["https://github.com/instrumenta/kubernetes-json-schema/blob/master/v1.18.1/all.json"] = "/*.k8s.yaml",
    ..., -- other schemas
  },
}

for _, lsp in pairs(LSP_SERVERS) do
  local config = {
    capabilities = lspCapabilities,
    settings = lspSettings[lsp],
    filetypes = lspFileTypes[lsp],
  }
  require("lspconfig")[lsp].setup(config)
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
