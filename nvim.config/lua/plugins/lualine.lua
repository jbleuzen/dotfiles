return {
	"nvim-lualine/lualine.nvim",
	config = function()
		-- Eviline config for lualine
		local lualine = require("lualine")

		-- Color table for highlights
		local colors = require("monokai").classic

		vim.api.nvim_set_hl(0, "LualineFilenameStatus", { fg = colors.red, bg = "#444444" })

		local theme = {
			normal = {
				a = { bg = colors.green, fg = "#005F00", gui = "bold" },
				b = { bg = "#585858", fg = "#BCBCBC" },
				c = { bg = "#303030", fg = "#9E9E9E" },
				z = { bg = "#BCBCBC", fg = "#000000" },
			},
			insert = {
				a = { bg = colors.aqua, fg = "#00303A", gui = "bold" },
			},
			visual = {
				a = { bg = colors.orange, fg = "#870000", gui = "bold" },
			},
			replace = {
				a = { bg = "#D70000", fg = colors.white, gui = "bold" },
			},
			command = {
				a = { bg = colors.purple, fg = "#333333", gui = "bold" },
				z = { bg = "#BCBCBC", fg = "#000000" },
			},
			inactive = {
				a = { bg = "#303030", fg = "#9E9E9E" },
			},
		}

		local componentMode = {
			{
				"mode",
				fmt = function(mode)
					return mode:sub(1, 1) -- Just return the first letter of the mode
				end,
				padding = { left = 1, right = 1 }, -- We don't need space before this
			},
		}

		local nvimTreeExtension = {
			sections = {
				lualine_a = componentMode,
				lualine_b = {
					{
						"branch",
						icon = "",
					},
				},
				lualine_y = {
					"progress",
				},
				lualine_z = {
					{
						"searchcount",
						separator = "|",
					},
					{
						"location",
					},
				},
			},
			filetypes = { "NvimTree" },
		}

		-- Config
		local config = {
			options = {
				-- Disable sections and component separators
				globalstatus = true, -- Display only one status bar for all panes
				-- disabled_filetypes = {'NvimTree'},
				refresh = { -- sets how often lualine should refresh it's contents (in ms)
					statusline = 500, -- The refresh option sets minimum time that lualine tries
					tabline = 500, -- to maintain between refresh. It's not guarantied if situation
					winbar = 500, -- arises that lualine needs to refresh itself before this time
				},
				section_separators = "",
				component_separators = "",
				theme = theme,
			},
			extensions = { nvimTreeExtension },
			sections = {
				lualine_a = componentMode,
				lualine_b = {
					{
						"branch",
						padding = { left = 0, right = 1 },
						icon = "",
					},
					{
						"filename",
						cond = function()
							return not vim.fn.bufname():match("^term:")
						end,
						color = { fg = colors.white, bg = "#444444" },
						file_status = true, -- Displays file status (readonly status, modified status)
						newfile_status = false, -- Display new file status (new file means no write after created)
						path = 1, -- 0: Just the filename 1: Relative path 2: Absolute path 3: Absolute path, with tilde as the home directory
						shorting_target = 40, -- Shortens path to leave 40 spaces in the window
						-- for other components. (terrible name, any suggestions?)
						symbols = {
							modified = "", -- injected via fmt() below, colored red
							readonly = "", -- injected via fmt() below, colored red
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for new created file before first writting
						},
						fmt = function(str)
							str = str:gsub("%s+$", "")
							if vim.bo.modified then
								str = str .. " %#LualineFilenameStatus#●%*"
							end
							if vim.bo.modifiable == false or vim.bo.readonly then
								str = str .. " %#LualineFilenameStatus#%*"
							end
							return str
						end,
					},
				},
				lualine_c = {
					{
						"diff",
						colored = true, -- Displays a colored diff status if set to true
						symbols = { added = "+", modified = "•", removed = "-" }, -- Changes the symbols used by the diff.
						source = nil, -- A function that works as a data source for diff.
						-- It must return a table as such:
						--   { added = add_count, modified = modified_count, removed = removed_count }
						-- or nil on failure. count <= 0 won't be displayed.
						separator = "·",
					},
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = { error = " ", warn = " ", hint = " ", info = " " },
						colored = true,
						diagnostics_color = {
							error = { fg = colors.red },
							warn = { fg = colors.orange },
							info = { fg = colors.yellow },
							hint = { fg = colors.aqua },
						},
						sections = { "error", "warn", "info", "hint" },
					},
				},
				lualine_x = {
					{
						"fileformat",
						cond = function()
							return vim.bo.fileformat ~= "unix"
						end,
						separator = "|",
					},
					{
						"filetype",
						cond = function()
							return not vim.bo.filetype:match("^Neogit") and vim.bo.filetype ~= "gitcommit"
						end,
						fmt = function(ft)
							local short = { typescript = "ts", typescriptreact = "tsx" }
							return short[ft] or ft
						end,
						icons_enabled = false,
					},
					{
						function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if next(clients) == nil then
								return ""
							end
							local names = {}
							for _, client in pairs(clients) do
								table.insert(names, client.name)
							end
							return table.concat(names, " · ")
						end,
						color = { bg = "#444444", fg = "#BCBCBC" },
					},
				},
				lualine_y = {
					"progress",
				},
				lualine_z = {
					{
						color = { fg = "#333333", bg = colors.orange },
						function()
							if vim.v.hlsearch == 0 then
								return ""
							end
							local last_search = vim.fn.getreg("/")
							if not last_search or last_search == "" then
								return ""
							end
							local searchcount = vim.fn.searchcount({ maxcount = 0 })
							return "Search '"
								.. last_search
								.. "' => ["
								.. searchcount.current
								.. "/"
								.. searchcount.total
								.. "]"
						end,
						separator = "|",
					},
					{
						"location",
						padding = { left = 1, right = 1 },
					},
				},
			},
			inactive_sections = {
				-- these are to remove the defaults
				lualine_a = {},
				lualine_b = {},
				lualine_c = {},
				lualine_v = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		}

		-- Now don't forget to initialize lualine
		lualine.setup(config)
	end,
}
