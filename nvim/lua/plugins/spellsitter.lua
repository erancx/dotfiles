require("spellsitter").setup {
    hl = "SpellBad",
    captures = {"comment"}
}

vim.spell = false
vim.g.spellsitter = true
vim.g.spellcheck = true
vim.o.spelloptions = "camel"
vim.o.spellcapcheck = "" -- don't check for capital letters at start of sentence
