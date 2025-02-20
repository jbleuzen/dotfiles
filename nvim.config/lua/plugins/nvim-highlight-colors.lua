return {
	"brenoprata10/nvim-highlight-colors",
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	config = function()
		-- Ensure termguicolors is enabled if not already
		vim.opt.termguicolors = true

		-- Setup nvim-highlight-colors with required configurations
		require("nvim-highlight-colors").setup({
			render = "background", -- or 'foreground' or 'first_column'
			enable_hex = true, -- Highlight hex colors
			enable_short_hex = true, -- Highlight short hex colors
			enable_rgb = true, -- Highlight rgb colors
			enable_hsl = true, -- Highlight hsl colors with 'hsl' keyword
			enable_var_usage = true, -- Highlight CSS variables
			enable_named_colors = true,
			enable_tailwind = true,
		})

		-- nvim-cmp integration (if needed)
		local cmp = require("cmp")
		cmp.setup({
			-- Other configurations can be added here
			formatting = {
				format = require("nvim-highlight-colors").format,
			},
		})
	end,
}
