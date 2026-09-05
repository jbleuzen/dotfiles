return {
	"Bekaboo/dropbar.nvim",
	event = "BufReadPre",
	config = function()
		vim.g.dropbar_disable_mouse = true

		local dropbar = require("dropbar")

		dropbar.setup({
			symbol = {
				on_click = false,
			},
			bar = {
				enable = function(buf, win, _)
					local ft = vim.bo[buf].filetype
					local bt = vim.bo[buf].buftype

					local excluded_filetypes = {
						"NvimTree",
						"Neogit",
						"gitcommit",
						"fzf",
						"lazy",
						"mason",
						"help",
					}

					local excluded_buftypes = {
						"nofile",
						"prompt",
						"terminal",
					}

					if vim.tbl_contains(excluded_filetypes, ft) then
						return false
					end

					if vim.tbl_contains(excluded_buftypes, bt) then
						return false
					end

					return true
				end,
				keymaps = {
					["<LeftMouse>"] = function() end,
				},
			},
			pick = {
				enable = false,
				keymaps = {
					["<LeftMouse>"] = function() end,
				},
			},
			menu = {
				enable = false,
				keymaps = {
					["<LeftMouse>"] = function() end,
				},
			},
			icons = {
				enable = true,
				kinds = {
					dir_icon = "",
				},
				ui = {
					bar = {
						separator = " > ",
					},
				},
			},
			sources = {
				treesitter = {
					max_depth = 1,
				},
				lsp = {
					max_depth = 2,
				},
				markdown = {
					max_depth = 0,
				},
			},
		})

		vim.api.nvim_set_hl(0, "DropBarIconUISeparator", {
			fg = "#8F908A",
			italic = true,
			bold = true,
		})
	end,
}
