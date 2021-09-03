local gl = require("galaxyline")
local colors = require("onedark.colors").setup()
local condition = require("galaxyline.condition")
local gls = gl.section

gls.left[1] = {
	FileIcon = {
		provider = "FileIcon",
		condition = condition.buffer_not_empty,
		highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg },
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
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.left[4] = {
	LineInfo = {
		provider = "LineColumn",
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
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
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		highlight = { colors.red, colors.bg },
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.left[7] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		highlight = { colors.yellow, colors.bg },
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.left[8] = {
	DiagnosticHint = {
		provider = "DiagnosticHint",
		icon = "  ",
		highlight = { colors.cyan, colors.bg },
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.left[9] = {
	DiagnosticInfo = {
		provider = "DiagnosticInfo",
		icon = "  ",
		highlight = { colors.blue, colors.bg },
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.left[10] = {
	DiffAdd = {
		provider = "DiffAdd",
		condition = condition.hide_in_width,
		icon = "  ",
		highlight = { colors.green, colors.bg },
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.left[11] = {
	DiffModified = {
		provider = "DiffModified",
		condition = condition.hide_in_width,
		icon = " 柳",
		highlight = { colors.orange, colors.bg },
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.left[12] = {
	DiffRemove = {
		provider = "DiffRemove",
		condition = condition.hide_in_width,
		icon = "  ",
		highlight = { colors.red, colors.bg },
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
	},
}

gls.right[1] = {
	FileEncode = {
		provider = "FileEncode",
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
		highlight = { colors.green, colors.bg, "bold" },
	},
}

gls.right[2] = {
	FileFormat = {
		provider = "FileFormat",
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
		highlight = { colors.green, colors.bg, "bold" },
	},
}

gls.right[3] = {
	GitIcon = {
		provider = function()
			return "  "
		end,
		condition = condition.check_git_workspace,
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
		highlight = { colors.violet, colors.bg, "bold" },
	},
}

gls.right[4] = {
	FileNameType = {
		provider = "FileTypeName",
		separator = " ",
		separator_highlight = { "NONE", colors.bg },
		highlight = { colors.blue, colors.bg },
	},
}

local get_lsp_client = function(msg)
	msg = msg or "LSP Inactive"
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end
	local lsps = ""
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			if lsps == "" then
				lsps = client.name
			else
				if not string.find(lsps, client.name) then
					lsps = lsps .. ", " .. client.name
				end
			end
		end
	end
	if lsps == "" then
		return msg
	else
		return lsps
	end
end

gls.right[5] = {
	ShowLspClient = {
		provider = get_lsp_client,
		condition = function()
			local tbl = { ["dashboard"] = true, [" "] = true }
			if tbl[vim.bo.filetype] then
				return false
			end
			return true
		end,
		separator = " ",
		highlight = { colors.blue, colors.bg, "bold" },
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
