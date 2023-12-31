local lsp = require('lsp-zero').preset({})
local telescope = require('telescope.builtin')

lsp.ensure_installed({
	'rust_analyzer',
	'tsserver',
	'eslint',
	'lua_ls',
	'pyright',
	'ltex',
	'texlab',
	'dockerls',
	'docker_compose_language_service'
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	-- ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
	-- ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete()
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })

	vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help)
	vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
	vim.keymap.set('n', 'gr', function() telescope.lsp_references() end)
	vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
		vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
	end)
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local sources = {
	-- formatting.isort.with({ extra_args = { "--profile", "black", "--line-length", "120" } }),
	-- formatting.black.with({ extra_args = { "--line-length", "120" } }),
	formatting.isort.with({ extra_args = { "--line-length", "120" } }),
	formatting.autopep8.with({ extra_args = { "--max-line-length", "120" } }),
	formatting.latexindent
}

null_ls.setup({ sources = sources })
