return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local colors = {
			red = "#FF005F",
			lightRed = "#D75F87",
			green = "#AFD700",
			darkGreen = "#005F00",
			orange = "#FA8419",
			blue = "#58D1EB",
			purple = "#9D65FF",
			background = "#121212",
			black = "#000000",
			white = "#FFFFFF",
		}

		require("bufferline").setup({
			highlights = {
				fill = {
					fg = colors.green,
					bg = colors.background,
				},
				background = {
					fg = colors.white,
					bg = colors.background,
				},
				buffer_visible = {
					fg = colors.green,
					bg = colors.background,
				},
				buffer_selected = {
					fg = colors.darkGreen,
					bg = colors.green,
				},
				diagnostic = {
					fg = colors.green,
					bg = colors.background,
				},
				diagnostic_visible = {
					fg = colors.background,
					bg = colors.background,
				},
				diagnostic_selected = {
					fg = colors.blue,
					bg = colors.green,
					-- gui = "bold"
				},
				-- HINT
				hint = {
					fg = colors.white,
					bg = colors.background,
				},
				hint_visible = {
					fg = colors.green,
					bg = colors.background,
				},
				hint_selected = {
					fg = colors.darkGreen,
					bg = colors.green,
					bold = true,
				},
				hint_diagnostic = {
					fg = colors.white,
					bg = colors.background,
				},
				hint_diagnostic_visible = {
					fg = colors.green,
					bg = colors.background,
				},
				hint_diagnostic_selected = {
					fg = colors.darkGreen,
					bg = colors.green,
					bold = true,
				},
				-- INFO
				info = {
					fg = colors.white,
					bg = colors.background,
				},
				info_visible = {
					fg = colors.white,
					bg = colors.background,
				},
				info_selected = {
					fg = colors.darkGreen,
					bg = colors.green,
				},
				info_diagnostic = {
					fg = colors.purple,
					bg = colors.background,
				},
				info_diagnostic_visible = {
					fg = colors.purple,
					bg = colors.background,
				},
				info_diagnostic_selected = {
					fg = colors.purple,
					bg = colors.green,
				},
				-- WARNING
				warning = {
					fg = colors.orange,
					bg = colors.background,
				},
				warning_visible = {
					fg = colors.orange,
					bg = colors.background,
				},
				warning_selected = {
					fg = colors.darkGreen,
					bg = colors.green,
				},
				warning_diagnostic = {
					fg = colors.orange,
					bg = colors.background,
				},
				warning_diagnostic_visible = {
					fg = colors.orange,
					bg = colors.background,
				},
				warning_diagnostic_selected = {
					fg = colors.orange,
					bg = colors.green,
				},
				-- ERROR
				error = {
					fg = colors.lightRed,
					bg = colors.background,
				},
				error_visible = {
					fg = colors.lightRed,
					bg = colors.background,
				},
				error_selected = {
					fg = colors.darkGreen,
					bg = colors.green,
				},
				error_diagnostic = { -- buffer not active but not visible
					fg = colors.lightRed,
					bg = colors.background,
				},
				error_diagnostic_visible = { -- buffer not active but visible in another pane
					fg = colors.lightRed,
					bg = colors.background,
				},
				error_diagnostic_selected = { -- buffer active
					fg = colors.lightRed,
					bg = colors.green,
				},
				--
				modified = {
					fg = colors.red,
					bg = colors.background,
				},
				modified_visible = {
					fg = colors.red,
					bg = colors.background,
				},
				modified_selected = {
					fg = colors.red,
					bg = colors.green,
				},
				duplicate = {
					fg = colors.white,
					bg = colors.background,
					-- gui = "bold"
				},
				duplicate_selected = {
					fg = colors.darkGreen,
					bg = colors.green,
					-- gui = "bold"
				},
				duplicate_visible = {
					fg = colors.green,
					bg = colors.background,
				},
				separator = {
					fg = colors.green,
					bg = colors.green,
				},
				separator_selected = {
					fg = colors.green,
					bg = colors.green,
				},
				separator_visible = {
					fg = colors.green,
					bg = colors.green,
				},
				indicator_selected = {
					fg = colors.green,
					bg = colors.green,
				},
				pick_selected = {
					fg = colors.green,
					bg = colors.green,
				},
				pick_visible = {
					fg = colors.green,
					bg = colors.green,
				},
				pick = {
					fg = colors.green,
					bg = colors.green,
				},
			},

			options = {
				-- diagnostics = false, -- Disabled for now or use "nvim_lsp"
				diagnostics = "nvim_lsp",
				numbers = "none",
				color_icons = true,
				always_show_bufferline = true,
				separator_style = { "", "" },
				tab_size = 5,
				indicator = {
					style = "none",
				},
				offsets = {
					{
						filetype = "NvimTree",
						text = function()
							local path = vim.fn.getcwd()
							return "   " .. string.upper(string.match(path, "[^/]+$"))
						end,
						highlight = "NvimTreeRootFolder",
						text_align = "left",
					},
				},
				show_buffer_icons = false, -- disable filetype icons for buffers
				show_buffer_close_icons = false,
				show_close_icon = false,
				show_tab_indicators = false,
				custom_filter = function(bufnr)
					-- if the result is false, this buffer will be shown, otherwise, this
					-- buffer will be hidden.
					-- filter out filetypes you don't want to see
					local exclude_ft = { "qf", "fugitive", "git" }
					local cur_ft = vim.bo[bufnr].filetype
					local should_filter = vim.tbl_contains(exclude_ft, cur_ft)
					if should_filter then
						return false
					end
					return true
				end,
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					if context.buffer:current() then
						return ""
					end
					local s = ""

					local a = 0
					for e, n in pairs(diagnostics_dict) do
						if e == "error" or e == "warning" then
							a = a + n
						end
					end
					local limitedCount = a > 9 and "9+" or tostring(a)
					return limitedCount == 0 and "" or limitedCount
				end,
				-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
				--   local icon = level:match("error") and "✕" or "!"
				--   local limitedCount = count > 9 and '9+' or count
				--   return "" .. limitedCount
				-- end
			},
		})

		-- Keymaps
		local keymap = vim.keymap
		keymap.set("n", "<left>", ":BufferLineCyclePrev<CR>", { silent = true })
		keymap.set("n", "<right>", ":BufferLineCycleNext<CR>", { silent = true })
		keymap.set("n", "<S-left>", ":BufferLineMovePrev<CR>", { silent = true })
		keymap.set("n", "<S-right>", ":BufferLineMoveNext<CR>", { silent = true })
	end,
}
