return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	priority = 1000, -- load early so it wins over other diagnostic UIs
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "modern",
			options = {
				show_source = { enabled = false, if_many = true },
				multilines = { enabled = true, always_show = false },
				show_all_diags_on_cursorline = false,
			},
		})

		-- plugin renders diagnostics itself; kill builtin virtual_text to avoid dupes
		vim.diagnostic.config({ virtual_text = false })
	end,
}
