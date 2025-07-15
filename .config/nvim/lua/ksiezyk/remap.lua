-- Map leader to space
vim.g.mapleader = " "

-- Explorer
vim.keymap.set("n", "<leader>pe", vim.cmd.Ex)

-- Center after navigation jump
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy/paste to/from clipboard, don't erase buffer when pasting over selection
vim.keymap.set({ "n", "v" }, "<C-y>", '"+y')
vim.keymap.set({ "n", "v" }, "<C-Y>", '"+yg_')
vim.keymap.set({ "n", "s" }, "<C-p>", '"+p')
vim.keymap.set({ "n", "s" }, "<C-P>", '"+P')
vim.keymap.set("x", "p", "\"_dP")

-- Navigate to prev/next file
vim.keymap.set("n", "<leader>mp", ":bprevious<CR>")
vim.keymap.set("n", "<leader>mn", ":bnext<CR>")

-- Show help diagnostic message
vim.keymap.set({ "n", "i" }, "<C-h>", vim.diagnostic.open_float)

-- Compile LaTex
vim.keymap.set({ "n" }, "<leader>c", ":execute '!pdflatex main && bibtex main && pdflatex main && pdflatex main'<CR>")

-- Quickfix list navigation
vim.keymap.set({ "n" }, "]c", "<Cmd>cnext<CR>")
vim.keymap.set({ "n" }, "[c", "<Cmd>cprevious<CR>")
