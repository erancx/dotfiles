local gl = require("galaxyline")
local colors = require("onedark.colors").setup()
local condition = require("galaxyline.condition")
local gls = gl.section

local mode_color = function()
    local mode_colors = {
        n = colors.green,
        i = colors.blue,
        c = colors.green,
        V = colors.purple,
        [""] = colors.purple,
        v = colors.purple,
        R = colors.red1,
        t = colors.blue,
    }
    if mode_colors[vim.fn.mode()] ~= nil then
        return mode_colors[vim.fn.mode()]
    else
        print(vim.fn.mode())
        return colors.purple
    end
end

gls.left[1] = {
    ViMode = {
        provider = function()
            local alias = {
                n = "NORMAL",
                i = "INSERT",
                c = "COMMAND",
                v = "VISUAL",
                V = "V-LINE",
                [""] = "VISUAL",
                R = "REPLACE",
                t = "TERMINAL",
                s = "SELECT",
                S = "S-LINE",
            }
            vim.api.nvim_command("hi GalaxyViMode guibg=" .. mode_color())
            if alias[vim.fn.mode()] ~= nil then
                return "  " .. alias[vim.fn.mode()] .. " "
            else
                return "  V-BLOCK "
            end
        end,
        highlight = { colors.bg, colors.bg, "bold" },
        separator = " ",
        separator_highlight = { "NONE", colors.bg },
    },
}

gls.left[2] = {
    GitBranch = {
        provider = "GitBranch",
        separator = " ",
        separator_highlight = { "NONE", colors.bg },
        condition = condition.check_git_workspace,
        highlight = { colors.yellow, colors.bg, "bold" },
    },
}

gls.left[3] = {
    FileName = {
        provider = { "FileName" },
        condition = condition.buffer_not_empty,
        highlight = { colors.magenta, colors.bg, "bold" },
    },
}

gls.left[4] = {
    LineInfo = {
        provider = "LineColumn",
        separator = " ",
        highlight = { colors.fg, colors.bg },
    },
}

gls.left[5] = {
    PerCent = {
        provider = "LinePercent",
        separator = " ",
        separator_highlight = { "NONE", colors.bg },
        highlight = { colors.fg, colors.bg, "bold" },
    },
}

gls.left[6] = {
    DiffAdd = {
        provider = "DiffAdd",
        condition = condition.hide_in_width,
        icon = "  ",
        highlight = { colors.green, colors.bg },
    },
}

gls.left[7] = {
    DiffModified = {
        provider = "DiffModified",
        condition = condition.hide_in_width,
        icon = " 柳",
        highlight = { colors.orange, colors.bg },
    },
}

gls.left[8] = {
    DiffRemove = {
        provider = "DiffRemove",
        condition = condition.hide_in_width,
        icon = "  ",
        highlight = { colors.red, colors.bg },
    },
}

gls.right[1] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = { colors.red, colors.bg },
    },
}

gls.right[2] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = { colors.yellow, colors.bg },
    },
}

gls.right[3] = {
    DiagnosticHint = {
        provider = "DiagnosticHint",
        icon = "  ",
        highlight = { colors.cyan, colors.bg },
    },
}

gls.right[4] = {
    DiagnosticInfo = {
        provider = "DiagnosticInfo",
        icon = "  ",
        highlight = { colors.blue, colors.bg },
    },
}

gls.right[5] = {
    FileEncode = {
        provider = "FileEncode",
        separator = " ",
        separator_highlight = { "NONE", colors.bg },
        highlight = { colors.green, colors.bg, "bold" },
    },
}

gls.right[6] = {
    FileFormat = {
        provider = "FileFormat",
        separator = " ",
        separator_highlight = { "NONE", colors.bg },
        highlight = { colors.green, colors.bg, "bold" },
    },
}

gls.right[7] = {
    FileNameType = {
        provider = "FileTypeName",
        separator = " ",
        separator_highlight = { "NONE", colors.bg },
        highlight = { colors.blue, colors.bg },
    },
}

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
    return string.format("[%s]", names)
end

gls.right[8] = {
    ShowLspClient = {
        provider = lsp_text_provider,
        separator = " ",
        highlight = { colors.purple, colors.bg, "bold" },
        icon = "LSP: ",
    },
}

gls.short_line_left[1] = {
    BufferType = {
        provider = "FileTypeName",
        separator = " ",
        separator_highlight = { "NONE", colors.bg },
        highlight = { colors.blue, colors.bg, "bold" },
    },
}

gls.short_line_left[2] = {
    SFileName = {
        provider = "SFileName",
        condition = condition.buffer_not_empty,
        highlight = { colors.fg, colors.bg, "bold" },
    },
}

gls.short_line_right[1] = {
    BufferIcon = {
        provider = "BufferIcon",
        highlight = { colors.fg, colors.bg },
    },
}
