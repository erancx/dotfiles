local nvim_lsp = require('lspconfig')
local lsp_status = require("lsp-status")
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

nvim_lsp.efm.setup {
  filetypes = {"yaml", "python", "sh", "json", "markdown"},
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

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        underline = true,
        virtual_text = true,
        signs = true,
        update_in_insert = true
    }
)

function lspSymbol(name, icon)
    vim.fn.sign_define("LspDiagnosticsSign" .. name, {text = icon, numhl = "LspDiagnosticsDefaul" .. name})
end

lspSymbol("Error", "")
lspSymbol("Warning", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")

local servers = { "yamlls", "bashls", "vimls", "jsonls", "dockerls", "gopls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

nvim_lsp.pyright.setup {
    on_attach = function(client)
        require'lsp_signature'.on_attach()
    end,
}

nvim_lsp.terraformls.setup {
    on_attach = on_attach_common,
    cmd = {"terraform-ls", "serve"},
    filetypes = {"tf"}
}

nvim_lsp.jsonls.setup {
    on_attach = on_attach,
    cmd = {"vscode-json-languageserver", "--stdio"}
}

local nvim_lsp = require'lspconfig'
local configs = require'lspconfig/configs'
configs.ciderlsp = {
 default_config = {
   cmd = {'/google/bin/releases/cider/ciderlsp/ciderlsp', '--tooltag=nvim-lsp' , '--noforward_sync_responses'};
   filetypes = {'c', 'cpp', 'java', 'proto', 'textproto', 'go', 'python', 'bzl'};
   root_dir = nvim_lsp.util.root_pattern('BUILD');
   settings = {};
 };
}
