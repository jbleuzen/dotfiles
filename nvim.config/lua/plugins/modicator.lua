return {
	"mawkler/modicator.nvim",
	dependencies = "tanvirtin/monokai.nvim", -- load after colorscheme
	init = function()
		-- These are required for Modicator to work
		vim.o.cursorline = true
		vim.o.number = true
		vim.o.termguicolors = true
	end,
	config = function()
		require("modicator").setup({
			-- Warn if any required option is missing. May emit false positives if some
			-- other plugin modifies them, which in that case you can just ignore
			show_warnings = false,
			highlights = {
				-- Default options for bold/italic
				defaults = {
					bold = true,
					italic = false,
				},
				-- Use `CursorLine`'s background color for `CursorLineNr`'s background
				use_cursorline_background = true,
			},
		})
	end,
}
