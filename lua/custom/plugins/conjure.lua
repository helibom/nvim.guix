return {
	{
		"Olical/conjure",
		ft = {
			"clojure",
			"fennel",
			"racket",
			"scheme",
			-- "typescript",
			-- "javascript",
		}, -- etc
		enabled = true,
		init = function()
			-- Set configuration options here
			-- Uncomment this to get verbose logging to help diagnose internal Conjure issues
			-- This is VERY helpful when reporting an issue with the project
			-- vim.g["conjure#debug"] = true


			vim.cmd([[let g:conjure#filetype#scheme = "conjure.client.guile.socket"]])
			vim.cmd([[let g:conjure#client#guile#socket#pipename = "/tmp/.guile-repl.socket"]])
		end,
	},
	{
		-- 'sigmaSd/conjure-deno',
		-- dev = true,
		-- dir = "~/dev/forks/conjure-deno"
	},
}
