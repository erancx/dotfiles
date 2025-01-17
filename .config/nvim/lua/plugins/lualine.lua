local function getclientnames()
  local clients = vim.lsp.get_clients()
  local clientnames_tbl = {}
  for _, v in pairs(clients) do
    if v.name then
      table.insert(clientnames_tbl, v.name)
    end
  end
  return table.concat(clientnames_tbl, ",")
end

local lsp_text_provider = function()
  local clients = vim.lsp.get_clients()
  if vim.tbl_isempty(clients) then
    return ""
  end
  local names = getclientnames()
  return string.format("%s", names)
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",

  opts = function(_, opts)
    opts.options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = "",
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {
          "alpha",
          "checkhealth",
          "dashboard",
          "snacks_dashboard",
          "fzf",
          "lazy",
          "mason",
          "TelescopePrompt",
        },
      },
      always_divide_middle = true,
      globalstatus = 1,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    }

    opts.sections = {
      lualine_a = {
        { "mode", separator = { left = "" }, right_padding = 2 },
      },
      lualine_b = {
        "filename",
        { "branch", icons_enabled = true, icon = "" },
        "filetype",
      },
      lualine_c = {},
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          sections = { "error", "warn" },
          symbols = { error = " ", warn = " " },
          colored = true,
          update_in_insert = false,
          always_visible = true,
        },
      },
      lualine_y = { lsp_text_provider },
      lualine_z = {
        "location",
        { "progress", separator = { right = "" } },
      },
    }

    opts.inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    }

    opts.tabline = {}
    opts.winbar = {}
    opts.inactive_winbar = {}
    opts.extensions = { "neo-tree", "lazy" }
  end,
}
