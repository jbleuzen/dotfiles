return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	ft = {
		"html",
		"xml",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"tsx",
		"jsx",
		"markdown",
		"astro",
		"php",
	},
	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true, -- auto close tags on `>`
				enable_rename = true, -- rename the pair when editing one tag
				enable_close_on_slash = false, -- auto close on `</`
			},
		})
	end,
}
