-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim',
		-- tag = '0.1.8',
		branch = 'master',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

	use({ 'rose-pine/neovim', as = 'rose-pine' })

	use({ 'folke/tokyonight.nvim', as = 'tokyonight' })

	use({ 'ThePrimeagen/harpoon' })

	use({ 'mbbill/undotree' })

	use({ 'tpope/vim-fugitive' })

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v4.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{
				-- Optional
				'williamboman/mason.nvim',
				run = function()
					pcall(vim.cmd, 'MasonUpdate')
				end,
			},
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'L3MON4D3/LuaSnip' }, -- Required
		}
	}

	use({ 'nvimtools/none-ls.nvim' })

	use({ 'lewis6991/gitsigns.nvim' })

	use({ 'alexghergh/nvim-tmux-navigation' })

	use({ 'github/copilot.vim' })

	use({
		"CopilotC-Nvim/CopilotChat.nvim",
		requires = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim" }, -- for curl, log and async functions
		}
	})

	use({ 'tomasky/bookmarks.nvim' })
end)
