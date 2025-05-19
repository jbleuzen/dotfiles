return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
				disable = {},
			},
			indent = {
				enable = true,
				disable = {},
			},
			auto_install = true,
			ensure_installed = {
				"astro",
				"bash",
				"comment",
				"css",
				"dockerfile",
				"fish",
				"html",
				"javascript",
				"json",
				"jsonc",
				"lua",
				"markdown",
				"markdown_inline",
				"tsx",
				"php",
				"tsx",
				"toml",
				"vim",
				"vue",
				"yaml",
			},
			autotag = {
				enable = false,
			},
		})

		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
	end,
}
