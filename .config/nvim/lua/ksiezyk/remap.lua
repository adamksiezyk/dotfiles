vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pe", vim.cmd.Ex)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({"n", "v"}, "<C-y>", '"+y')
vim.keymap.set({"n", "v"}, "<C-Y>", '"+yg_')
vim.keymap.set({"n", "s"}, "<C-p>", '"+p')
vim.keymap.set({"n", "s"}, "<C-P>", '"+P')
vim.keymap.set("x", "p", "\"_dP")

vim.keymap.set("n", "<leader>mp", ":bprevious<CR>")
vim.keymap.set("n", "<leader>mn", ":bnext<CR>")

vim.keymap.set({"n"}, "<leader>c", ":execute '!pdflatex main && bibtex main && pdflatex main && pdflatex main'<CR>")
