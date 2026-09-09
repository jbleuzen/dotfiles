return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason = require("mason")
		local colors = require("monokai").classic

		mason.setup({
			ui = {
				-- Whether to automatically check for new versions when opening the :Mason window.
				check_outdated_packages_on_open = true,
				-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
				border = "rounded",
				icons = {
					package_installed = " ",
					package_pending = " ",
					package_uninstalled = "󰅖 ",
				},
			},
		})

		require("mason-lspconfig").setup({
			-- A list of servers to automatically install if they're not already installed
			ensure_installed = {
				"astro",
				"bashls",
				"cssls",
				"eslint",
				"graphql",
				"html",
				"jsonls",
				"lua_ls",
				"pylsp",
				"ruby_lsp",
				"tailwindcss",
				"ts_ls",
				"yamlls",
			},

			automatic_installation = true,
		})

		local lspconfig = vim.lsp.config

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		lspconfig("astro", {
			filetypes = { "astro" },
		})

		lspconfig("ts_ls", {})

		lspconfig("jsonls", {})

		lspconfig("yamlls", {})

		lspconfig("graphql", {})

		lspconfig("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
				},
			},
		})

		lspconfig("tailwindcss", {
			filetypes = {
				"html",
				"css",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
		})

		-- Diagnostic gutter icons (same glyphs/colors as lualine's diagnostics component)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "",
				},
			},
			virtual_text = {
				prefix = function(diagnostic)
					local icons = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					}
					return icons[diagnostic.severity]
				end,
				source = "if_many",
				spacing = 2,
			},
			underline = true,
			severity_sort = true,
		})

		vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = colors.red })
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = colors.orange })
		vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = colors.yellow })
		vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = colors.aqua })

		-- vim.cmd([[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#ffffff]])

		local function goto_definition_filtered()
			vim.lsp.buf.definition({
				on_list = function(options)
					-- Filtrer les emplacements pour exclure node_modules
					local items = {}
					for _, item in ipairs(options.items) do
						if not string.find(item.filename, "node_modules") then
							table.insert(items, item)
						end
					end
					if #items == 0 then
						items = options.items
					end
					vim.fn.setqflist({}, " ", { title = options.title, items = items })
					vim.cmd("cfirst")
				end,
			})
		end

		-- Keymaps
		local keymap = vim.keymap
		local opts = { silent = true, noremap = true }
		keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)
		keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		keymap.set("n", "gd", goto_definition_filtered, opts)
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		keymap.set("n", "gi", ":FzfLua lsp_implementations<CR>", opts)
		keymap.set("n", "K", vim.lsp.buf.hover, opts)
		keymap.set("n", "<Leader>s", vim.lsp.buf.rename, opts)
		keymap.set(
			"n",
			"gr",
			':lua require"fzf-lua".lsp_references({ winopts = { height=0.4, width=1, row=1 } })<CR>',
			opts
		)
	end,
}
