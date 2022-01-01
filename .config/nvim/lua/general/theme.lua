local onedarkpro = require("onedarkpro")
onedarkpro.setup({
    styles = {
        comments = "italic",
        keywords = "italic",
    },
    colors = {
        onedark = {
            brackets = "#E33D1A", -- fg / red
        },
    },
    hlgroups = {
        ModeMsg = { link = "LineNr" },
        TSPunctBracket = { fg = "${brackets}" }, -- Brackets
        TSPunctSpecial = { fg = "${brackets}" }, -- Brackets
        -- LSP plugin
        LspDiagnosticsVirtualTextError = { fg = "${red}", style = "italic,underline" },
        LspDiagnosticsVirtualTextWarning = { fg = "${yellow}", style = "italic,underline" },
        LspDiagnosticsVirtualTextInformation = { fg = "${blue}", style = "italic,underline" },
        LspDiagnosticsVirtualTextHint = { fg = "${cyan}", style = "italic,underline" },
    },
    options = {
        cursorline = true,
    },
})
onedarkpro.load()
