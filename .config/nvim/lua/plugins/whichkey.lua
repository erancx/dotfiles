local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = false,
  },
  window = {
    border = "single", -- none, single, double, shadow
  },
}

local opts = {
  prefix = "<leader>",
}

local mappings = {
  ["md"] = { "<cmd>MarkdownPreviewToggle<CR>", "MarkdownPreviewToggle" },
  f = {
    name = "Find",
    a = { "<cmd>Telescope find_files cwd=~/workspace/repo<cr>", "Telescope find files in ~/workspace/repo" },
    f = { "<cmd>Telescope find_files hidden=true<cr>", "Find files in current repo" },
    g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
    l = { "<cmd>Telescope oldfiles<cr>", "List old files" },
    b = { "<cmd>Telescope file_browser<cr>", "Browse files" },
    p = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "List projects" },
    t = { "<cmd>Telescope filetypes<CR>", "List projects" },
  },
  g = {
    name = "Git",
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>G blame<cr>", "Git blame" },
    B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope diagnostics bufnr=<cr>",
      "Document Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.format{async = true}<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
  },
  w = {
    name = "Windows",
    s = { "<cmd>FocusSplitDown<cr>", "Focus Split Down" },
    w = { "<cmd>FocusSplitUp<cr>", "Focus Split Up" },
    a = { "<cmd>FocusSplitLeft<cr>", "Focus Split Left" },
    d = { "<cmd>FocusSplitRight<cr>", "Focus Split Right" },
    m = { "<cmd>FocusMaximise<cr>", "Focus Maximase" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
