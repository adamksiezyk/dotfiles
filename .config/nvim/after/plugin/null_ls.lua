local null_ls = require('null-ls')
local formatting = null_ls.builtins.formatting
local h = require('null-ls.helpers')
local line_len = "120"

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
			"--wrap-summaries", line_len,
			"--wrap-descriptions", line_len,
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
	formatting.black.with({ extra_args = { "--line-length", line_len } }),
	-- formatting.autopep8.with({ extra_args = { "--max-line-length", line_len, "--experimental" } }),
	docformatter,
	formatting.latexindent
}
null_ls.setup({ sources = sources })
