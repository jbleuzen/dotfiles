return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local actions = require("fzf-lua.actions")
		local utils = require("fzf-lua.utils")
		local path = require("fzf-lua.path")
		local FzfLua = require("fzf-lua")

		FzfLua.setup({
			file_icon_padding = " ",
			exec_empty_query = true, -- Displays results event if no search typed
			fzf_opts = {
				["--tiebreak"] = "begin", -- Proper sort of results (see https://github.com/ibhagwan/fzf-lua/issues/411#issuecomment-1125527931)
				["--exact"] = true, -- Disables regular expression
				["--pointer"] = " ", -- Pointer for the current line
				["--marker"] = " ", -- Marker when selecting items
			},
			fzf_colors = {
				["gutter"] = { "bg", "Normal" },
			},
			defaults = {
				cwd_prompt = false,
				header = false,
				file_icons = false,
				color_icons = true,
				winopts = {
					title = false,
					title_pos = "center", -- 'left', 'center' or 'right'
					title_flags = true,
					row = 0,
					height = 0.65,
					fullscreen = false,
					preview = {
						title = false,
					},
				},
			},
			keymap = {
				builtin = {
					["<Esc>"] = "abort",
					["<F1>"] = "toggle-help",
					["<F2>"] = "toggle-fullscreen",
					["<F3>"] = "toggle-preview-wrap",
					["<C-<Space>>"] = "toggle-preview",
					["<C-j>"] = "preview-page-down",
					["<C-k>"] = "preview-page-up",
					["<C-h>"] = "preview-page-reset",
					["<C-l>"] = "preview-page-reset",
				},
			},
			grep = {
				winopts = {
					title = false,
					on_create = function()
						vim.keymap.set("t", "<S-CR>", "<C-q>")
					end,
				},
				-- prompt = " Search ❯ ",
				multiprocess = true, -- Breaks search withtout multiprocess to false
				input_prompt = " Search for ❯ ",
				-- fzf_opts = {
				-- 	["--delimiter"] = ":",
				-- 	["--with-nth"] = "4",
				-- },
				-- rg_opts = "--column --line-number --no-heading --smart-case --fixed-strings",
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
				actions = {
					["ctrl-r"] = { actions.toggle_ignore },
					["ctrl-g"] = { actions.grep_lgrep },
				},
			},
			files = {
				winopts = {
					title = false,
					preview = { hidden = true },
					on_create = function()
						vim.keymap.set("t", "<S-CR>", "<C-q>")
					end,
				},
				prompt = " Files ❯ ",
				cwd_prompt = true,
				cwd_prompt_shorten_len = 32, -- shorten prompt beyond this length
				cwd_prompt_shorten_val = 1, -- shortened path parts length
				fd_opts = "--type f --exclude '*.ttf' --exclude '*.woff*' --exclude '*.git'",
				git_icons = true, -- show git icons?
			},
			quickfix = {
				winopts = {
					title = false,
					height = 0.4, -- 40% height of screen
					width = 1.0, -- Full width
					row = 1,
					border = "rounded",
					on_create = function()
						-- creates a local buffer mapping translating <S-BS> to delete quickfix entry
						vim.keymap.set("t", "<S-BS>", "<C-d>")
					end,
				},
				prompt = " Quickfix ❯ ",
				actions = {
					["default"] = function(selected, opts)
						-- Opens a file from quickfix in new listed buffer
						local file = path.entry_to_file(selected[1], opts)
						local bufnr = vim.fn.bufadd(file.bufname)
						vim.fn.bufload(bufnr)
						vim.api.nvim_set_current_buf(bufnr)
						vim.api.nvim_win_set_cursor(0, { file.line, file.col })
						vim.api.nvim_buf_set_option(bufnr, "buflisted", true)
					end,
					["ctrl-d"] = {
						fn = function(selected, opts)
							actions.list_del(selected, opts)
						end,
						reload = true,
					},
				},
			},
			git = {
				branches = {
					prompt = " Branch ❯ ",
					cmd = "git branch --sort=-committerdate",
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
					["ctrl-q"] = function(selected, opts)
						-- Directly opens fzf quickfix picker
						actions.file_sel_to_qf(selected, opts)
						vim.api.nvim_command("silent! FzfLua quickfix")
						vim.cmd.cclose()
					end,
				},
			},
		})

		-- Keymaps
		local keymap = vim.keymap
		keymap.set("n", "<Leader>f", ":FzfLua files<CR>", { desc = "Open FzfLua file selector", silent = true })
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
		end, { desc = "Open FzfLua file selector", silent = true })
		keymap.set("n", "<Leader>r", ":FzfLua resume<CR>", { desc = "Open FzfLua file selector", silent = true })
		keymap.set("n", "<Leader>g", ":FzfLua live_grep<CR>", { desc = "Open FzfLua grep selector", silent = true })
		keymap.set("n", "<Leader>k", ":FzfLua grep_cword<CR>", { desc = "Open FzfLua file selector", silent = true })
		-- keymap.set("n", "<Leader>k", function()
		-- 	local word = vim.fn.expand("<cword>")
		-- 	require("fzf-lua").grep_cword({
		-- 		rg_opts = "--column --line-number --no-heading --smart-case",
		-- 		prompt = " Search in '" .. word .. "' ❯ ",
		-- 	})
		-- end, { desc = "Open FzfLua file selector" })
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
		keymap.set("n", "<Leader>b", ":FzfLua git_branches<CR>", { desc = "Open FzfLua file selector", silent = true })
		keymap.set("n", "<Leader>q", ":FzfLua quickfix<CR>", { desc = "Open FzfLua file selector", silent = true })
	end,
}
