function Color(color)
	color = color or "rose-pine"
	require('rose-pine').setup({ disable_italics = true })
	vim.cmd.colorscheme(color)
end

Color()

