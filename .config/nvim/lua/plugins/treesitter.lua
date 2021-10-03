require("nvim-treesitter.configs").setup({
    ensure_installed = { "bash", "go", "java", "javascript", "json", "lua", "python", "yaml", "hcl" },
    highlight = { enable = true, use_languagetree = true },
    indent = { enable = true },
    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = true },
        smart_rename = { enable = true },
    },
})
