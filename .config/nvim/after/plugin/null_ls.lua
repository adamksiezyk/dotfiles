local null_ls = require('null-ls')
local formatting = null_ls.builtins.formatting
local h = require('null-ls.helpers')

local docformatter = h.make_builtin({
	name = "docformatter",
	meta = {
		url = "",
		description = "",
	},
	method = null_ls.methods.FORMATTING,
	filetypes = { "python" },
	generator_opts = {
		command = "docformatter",
		args = {
			"--wrap-summaries", "120",
			"--wrap-descriptions", "120",
			"--pre-summary-newline",
			"--black",
			"-",
		},
		to_stdin = true,
	},
	factory = h.formatter_factory,
})

local sources = {
	formatting.isort.with({ extra_args = { "--profile", "black" } }),
	formatting.black.with({ extra_args = { "--line-length", "120" } }),
	-- formatting.autopep8,
	docformatter,
	formatting.latexindent
}
null_ls.setup({ sources = sources })
