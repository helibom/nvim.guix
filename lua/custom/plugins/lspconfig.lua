-- 	Regarding Mason, the plugin allow you to ->
-- 	- register a setup hook with lspconfig that ensures servers installed with mason.nvim are set up with the necessary configuration
--	- provide extra convenience APIs such as the :LspInstall command
-- 	- allow you to (i) automatically install, and (ii) automatically set up a predefined list of servers
-- 	- translate between lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"csharp_ls",
				"clojure_lsp",
				"marksman",
				"bashls",
				"lua_ls",
				"jsonls",
				"yamlls",
				"ts_ls",
				"cssls",
				"tailwindcss",
				-- "pylsp",
			},
		},
		version = "1.*",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities() -- autocompletion

			require("mason").setup()

			-- ######### TYPESCRIPT SERVERS ############# --
			vim.lsp.config["ts_ls"] = {
				capabilities = capabilities,
				-- FIX: To whatever the equivalent is in Neovim >= v11 w/ vim.lsp.config feature
				-- root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json"),
				filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
				single_file_support = false,
				on_attach = function(client, bufnr)
					-- Disable formatting from tsserver
					client.server_capabilities.document_formatting = false
				end,
			}

			-- ######### OTHER SERVERS ############# --
			vim.lsp.config["marksman"] = { capabilities = capabilities, filetypes = { "markdown" } }
			vim.lsp.config["csharp_ls"] = { capabilities = capabilities }
			vim.lsp.config["clojure_lsp"] = { capabilities = capabilities }
			vim.lsp.config["lua_ls"] = { capabilities = capabilities }
			vim.lsp.config["jsonls"] = { capabilities = capabilities }
			vim.lsp.config["yamlls"] = { capabilities = capabilities }
			vim.lsp.config["cssls"] = { capabilities = capabilities }
			vim.lsp.config["tailwindcss"] = { capabilities = capabilities }
			vim.lsp.config["bashls"] = { capabilities = capabilities }

			vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "LSP Rename" })
			vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
			vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "LSP References" })
			vim.keymap.set("i", "<C-Space>", vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					-- local client = vim.lsp.get_client_by_id(args.data.client_id)
					-- if client and client.supports_method('textDocument/documentation') then
					-- Create a keymap for vim.lsp.buf.
					-- end
					if client and client.supports_method("textDocument/implementation") then
						-- Create a keymap for vim.lsp.buf.implementation
						vim.keymap.set("n", "cd", vim.lsp.buf.implementation, { desc = "LSP Implementation" })
					end
				end,
			})
		end,
	},
}
