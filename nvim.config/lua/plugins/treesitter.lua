return {
	"romus204/tree-sitter-manager.nvim",
	dependencies = {}, -- tree-sitter CLI must be installed system-wide
	config = function()
		require("tree-sitter-manager").setup({
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
		})
	end,
}
