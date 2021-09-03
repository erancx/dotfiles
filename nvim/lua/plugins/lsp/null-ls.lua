local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
	b.formatting.prettierd.with({
		filetypes = { "json", "yaml", "markdown" },
	}),
	b.formatting.stylua.with({
		condition = function(utils)
			return utils.root_has_file("stylua.toml")
		end,
	}),
	b.code_actions.gitsigns,
	b.diagnostics.write_good,
	b.diagnostics.markdownlint,
	b.diagnostics.shellcheck.with({ diagnostics_format = "[#{c}] #{m} (#{s})" }),
	b.diagnostics.flake8,
	b.diagnostics.misspell,
	b.formatting.black,
	b.formatting.isort,
	b.formatting.goimports,
	b.formatting.shfmt,
	b.formatting.gofmt,
	b.formatting.terraform_fmt,
	b.formatting.stylua,
}

local M = {}
M.setup = function(on_attach)
	null_ls.config({
		-- debug = true,
		sources = sources,
	})
	require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
end

return M
