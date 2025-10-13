return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local actions = require("fzf-lua.actions")
		local utils = require("fzf-lua.utils")

		require("fzf-lua").setup({
			file_icon_padding = " ",
			exec_empty_query = true, -- Displays results event if no search typed
			fzf_opts = {
				["--exact"] = true, -- Disables regular expression
				["--pointer"] = " ",
			},
			defaults = {
				cwd_prompt = false,
				header = false,
				file_icons = false,
				color_icons = true,
				winopts = {
					title = false,
					title_pos = "center", -- 'left', 'center' or 'right'
					title_flags = false,
					backdrop = 50,
					row = 0,
					height = 0.65,
					fullscreen = false,
					preview = {
						title = false,
					},
				},
			},
			fzf_colors = {
				["gutter"] = "-1", -- Hide the gutter used by the pointer
			},
			keymap = {
				builtin = {
					["<Esc>"] = "abort",
					["<F1>"] = "toggle-help",
					["<F2>"] = "toggle-fullscreen",
					["<F3>"] = "toggle-preview-wrap",
					-- nvim registers <C-/> as <C-_>, use insert mode
					-- and press <C-v><C-/> should output ^_
					["<C-<Space>>"] = "toggle-preview",
					["<C-j>"] = "preview-page-down",
					["<C-k>"] = "preview-page-up",
					["<C-h>"] = "preview-page-reset",
					["<C-l>"] = "preview-page-reset",
				},
			},
			grep = {
				rg_opts = "--column --line-number --no-heading --smart-case --fixed-strings",
				winopts = { title = false },
				prompt = " Search ❯ ",
				input_prompt = " Search for ❯ ",
				fzf_opts = {
					["--delimiter"] = ":",
					["--with-nth"] = "4",
				},
				fn_transform = function(entry)
					local file, line, position, _ = entry:match("([^:]+):(%d+):(%d+)(.+)")
					if file and line then
						local filename = utils.ansi_codes.white(file:match("[^/]+$") or file)
						local folder = utils.ansi_codes.green(utils.ansi_codes.italic(file:match("(.+)/[^/]+$")))
						local lineNb = utils.ansi_codes.grey(utils.ansi_codes.italic("(" .. line .. ")"))
						return string.format("%s:%s:%s:%s  %s %s", file, line, position, filename, folder, lineNb)
					end
					return entry
				end,
			},
			files = {
				winopts = { title = false, preview = { hidden = true } },
				prompt = " Files ❯ ",
				fd_opts = "--type f --exclude '*.ttf' --exclude '*.woff*' --exclude '*.git'",
				git_icons = true, -- show git icons?
				header_prefix = "",
			},
			quickfix = {
				winopts = { title = false },
				prompt = "  Quickfix ❯ ",
			},
			git = {
				branches = {
					prompt = " Branch ❯ ",
					cmd = "git branch --sort=-committerdate --format='%(refname:short)'",
					preview = "git log {1} --no-merges -1 --pretty=%s",
					winopts = {
						title = false,
						height = 20,
						width = 100,
						preview = {
							scrollbar = "false",
							scrolloff = 10,
							hidden = false,
							layout = "vertical",
							vertical = "down:1",
							winopts = {
								height = 1, -- force 1 ligne
							},
						},
						on_create = function()
							-- creates a local buffer mapping translating <M-BS> to <C-u>
							vim.keymap.set("t", "<S-CR>", "<C-n>")
							vim.keymap.set("t", "<S-BS>", "<C-d>")
						end,
					},
					actions = {
						["default"] = actions.git_switch,
						["ctrl-n"] = { fn = actions.git_branch_add, field_index = "{q}", reload = false },
						["ctrl-d"] = { fn = actions.git_branch_del, reload = true },
					},
					cmd_add = { "git", "checkout", "-b" },
					cmd_del = { "git", "branch", "--delete" },
				},
				icons = {
					["M"] = { icon = "●", color = "green" },
					["D"] = { icon = "-", color = "red" },
					["A"] = { icon = "+", color = "green" },
					["R"] = { icon = "➜", color = "yellow" },
					["C"] = { icon = "C", color = "yellow" },
					["T"] = { icon = "T", color = "magenta" },
					["?"] = { icon = "?", color = "green" },
				},
			},
			actions = {
				files = {
					-- instead of the default action 'actions.file_edit_or_qf'
					-- it's important to define all other actions here as this
					-- table does not get merged with the global defaults
					["default"] = actions.file_edit,
					["ctrl-s"] = actions.file_split,
					["ctrl-v"] = actions.file_vsplit,
					["ctrl-t"] = actions.file_tabedit,
					["ctrl-q"] = actions.file_sel_to_qf,
				},
			},
		})

		-- Keymaps
		local keymap = vim.keymap
		keymap.set("n", "<Leader>f", ":FzfLua files<CR>", { desc = "Open FzfLua file selector" })
		keymap.set("n", "<Leader>F", function()
			require("fzf-lua").files({
				cmd = "fd --type d --hidden --exclude '.*'",
				prompt = " Select folder ❯ ",
				actions = {
					["default"] = function(selected)
						local sanitized_path = selected[1]:gsub("^[^%w~/.]+", "")
						require("fzf-lua").files({
							cwd = sanitized_path,
							prompt = ' Files in "' .. sanitized_path:sub(1, -2) .. '" ❯ ',
						})
					end,
				},
			})
		end, { desc = "Open FzfLua file selector" })
		keymap.set("n", "<Leader>r", ":FzfLua resume<CR>", { desc = "Open FzfLua file selector" })
		-- Don't know why live_grep only when multiprocess is false
		keymap.set("n", "<Leader>g", ":FzfLua live_grep multiprocess=false<CR>", { desc = "Open FzfLua file selector" })
		keymap.set("n", "<Leader>k", ":FzfLua grep_cword<CR>", { desc = "Open FzfLua file selector" })
		keymap.set("n", "<Leader>k", function()
			local word = vim.fn.expand("<cword>")
			require("fzf-lua").grep_cword({
				rg_opts = "--column --line-number --no-heading --smart-case",
				prompt = " Search in '" .. word .. "' ❯ ",
			})
		end, { desc = "Open FzfLua file selector" })
		keymap.set("n", "<Leader>G", function()
			require("fzf-lua").files({
				cmd = "fd --type d --hidden --exclude '.*'",
				prompt = " Search in folder ❯ ",
				actions = {
					["default"] = function(selected)
						local sanitized_path = selected[1]:gsub("^[^%w~/.]+", "")
						require("fzf-lua").live_grep({
							cwd = sanitized_path,
							prompt = ' Search in "' .. sanitized_path:sub(1, -2) .. '" ❯ ',
						})
					end,
				},
			})
		end, { desc = "Open FzfLua file selector" })
		keymap.set("n", "<Leader>b", ":FzfLua git_branches<CR>", { desc = "Open FzfLua file selector" })
		keymap.set("n", "<Leader>q", ":FzfLua quickfix<CR>", { desc = "Open FzfLua file selector" })
	end,
}
