require("null-ls").setup({
    sources = {
        require("null-ls").builtins.code_actions.gitsigns,
        require("null-ls").builtins.diagnostics.write_good,
        require("null-ls").builtins.diagnostics.markdownlint,
        require("null-ls").builtins.diagnostics.shellcheck.with({ diagnostics_format = "[#{c}] #{m} (#{s})" }),
        require("null-ls").builtins.diagnostics.flake8,
        require("null-ls").builtins.diagnostics.hadolint,
        require("null-ls").builtins.formatting.codespell,
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.prettier.with({
            filetypes = { "html", "json", "yaml", "markdown" },
            extra_args = { "--fast" },
        }),
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.goimports,
        require("null-ls").builtins.formatting.shfmt,
        require("null-ls").builtins.formatting.gofmt,
        require("null-ls").builtins.formatting.terraform_fmt,
        require("null-ls").builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces" },
        }),
    },
})
