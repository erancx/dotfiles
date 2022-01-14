local function getclientnames()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.buf_get_clients(bufnr)
    local clientnames_tbl = {}
    for _, v in pairs(clients) do
        if v.name then
            table.insert(clientnames_tbl, v.name)
        end
    end
    return table.concat(clientnames_tbl, ",")
end

local lsp_text_provider = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.buf_get_clients(bufnr)
    if vim.tbl_isempty(clients) then
        return ""
    end
    local names = getclientnames()
    return string.format("%s", names)
end

require("lualine").setup({
    options = {
        theme = "onedarkpro",
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "NvimTree" },
    },
    sections = {
        lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = {
            "filename",
            { "branch", icons_enabled = true, icon = "" },
            "filetype",
        },
        lualine_c = {
            {
                function()
                    local gps = require("nvim-gps")
                    return gps.get_location()
                end,
                cond = function()
                    local gps = require("nvim-gps")
                    return pcall(require, "nvim-treesitter.parsers") and gps.is_available()
                end,
                color = { fg = "#ff9e64" },
            },
        },
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
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
})
