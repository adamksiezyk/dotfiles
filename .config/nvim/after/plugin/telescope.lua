local telescope = require('telescope')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')

local theme_cursor = themes.get_cursor()
theme_cursor['jump_type'] = 'never'

vim.keymap.set('n', '<leader>pf', function() builtin.find_files({ hidden = true }); end)
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }); end)
vim.keymap.set('n', 'gd', function() builtin.lsp_definitions(theme_cursor) end)
vim.keymap.set('n', 'gr', function() builtin.lsp_references(theme_cursor) end)
vim.keymap.set('n', '<leader>la', function() builtin.lsp_document_symbols() end)
vim.keymap.set('n', '<leader>lc', function() builtin.lsp_document_symbols({ symbols = { 'class' } }) end)
vim.keymap.set('n', '<leader>lf', function() builtin.lsp_document_symbols({ symbols = { 'method', 'function' } }) end)
vim.keymap.set('n', '<leader>pa', function() builtin.lsp_dynamic_workspace_symbols() end)
