local tsconf = require'nvim-treesitter.configs'
if not tsconf then
   vim.cmd [[ echom 'Cannot load `nvim-treesitter.configs`' ]]
   return
end

tsconf.setup {
    ensure_installed = {'bash', 'go', 'java', 'javascript', 'json', 'lua', 'python', 'yaml'},
    highlight = { enable = true, use_languagetree = true },
    indent = { enable = true },
    refactor = {
      highlight_definitions = { enable = true },
      highlight_current_scope = { enable = false },
      smart_rename = { enable = true},
    },
}
