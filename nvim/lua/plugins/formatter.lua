local function prettier_formatter()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end

require("formatter").setup(
  {
    logging = false,
    filetype = {
      json = {prettier_formatter},
      yaml = {prettier_formatter},
      markdown = {prettier_formatter},
      typescriptreact = {prettier_formatter},
      javascript = {prettier_formatter},
      typescript = {prettier_formatter},
      html = {prettier_formatter},
      css = {prettier_formatter},
      sh = {
        function()
          return {exe = "shfmt", args = {"-i", 4}, stdin = true}
        end
      },
      python = {
        -- isort
        function()
          return {
            exe = "isort",
            args = {"-"},
            stdin = true
          }
        end,
        -- docformatter
        function()
          return {
            exe = "docformatter",
            args = {"-"},
            stdin = true
          }
        end,
        -- black
        function()
          return {
            exe = "black",
            args = {"-l", 79, "-"},
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      },
      go = {
        -- gofmt
        function()
          return {
            exe = "gofmt",
            stdin = true
          }
        end
      }
    }
  }
)
