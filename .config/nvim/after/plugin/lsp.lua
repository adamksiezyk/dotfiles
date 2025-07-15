local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')

require('mason').setup({})
require('mason-lspconfig').setup({
	-- Replace the language servers listed here
	-- with the ones you want to install
	ensure_installed = {
		'rust_analyzer',
		'ts_ls',
		'eslint',
		'lua_ls',
		'pyright',
		'ltex',
		'texlab',
		'dockerls',
		'docker_compose_language_service',
	},
	handlers = {
		function(server_name)
			lspconfig[server_name].setup({})
		end,
		lspconfig.lua_ls.setup(lsp.nvim_lua_ls()),
	},
})

local cmp = require('cmp')
cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
	mapping = cmp.mapping.preset.insert({
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
		['<C-Space>'] = cmp.mapping.complete()
	}),
	completion = {
		autocomplete = false,
	},
})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })

	vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help)
	vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
	vim.keymap.set({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format({ async = false, timeout_ms = 10000 }) end)
end)

lsp.setup()
