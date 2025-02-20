return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local actions = require("fzf-lua.actions")

		require("fzf-lua").setup({
			file_icon_padding = " ",
			fzf_opts = {
				["--exact"] = true, -- Désactive les expressions régulières
				["--pointer"] = "> ",
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
			keymap = {
				builtin = {
					["<Esc>"] = "abort",
					["<F1>"] = "toggle-help",
					["<F2>"] = "toggle-fullscreen",
					["<F3>"] = "toggle-preview-wrap",
					-- nvim registers <C-/> as <C-_>, use insert mode
					-- and press <C-v><C-/> should output ^_
					["<C- >"] = "toggle-preview",
					["<C-j>"] = "preview-page-down",
					["<C-k>"] = "preview-page-up",
					["<C-h>"] = "preview-page-reset",
					["<C-l>"] = "preview-page-reset",
				},
			},
			grep = {
				rg_opts = "--column --line-number --no-heading --color=always --smart-case -F",
				winopts = { title = false },
				prompt = " Search ❯ ",
				input_prompt = "Grep For❯ ",
			},
			files = {
				winopts = { title = false, preview = { hidden = true } },
				preview = {},
				prompt = " Files ❯ ",
				fd_opts = "--type f --exclude '*.ttf' --exclude '*.woff*' --exclude '*.git'",
				git_icons = true, -- show git icons?
			},
			git = {
				branches = {
					prompt = " GitBranch ❯ ",
					winopts = { title = false, preview = { hidden = true } },
					actions = {
						["default"] = actions.git_switch,
						["ctrl-n"] = { fn = actions.git_branch_add, field_index = "{q}", reload = false },
						["ctrl-d"] = { fn = actions.git_branch_del, reload = true },
					},
					cmd = "git branch --list",
					cmd_add = { "git", "checkout", "-b" },
					cmd_del = { "git", "branch", "--delete" },
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
		keymap.set("n", "<Leader>k", ":FzfLua grep_cword<CR>", { desc = "Open FzfLua file selector" })
		keymap.set("n", "<Leader>g", ":FzfLua live_grep<CR>", { desc = "Open FzfLua file selector" })
		keymap.set("n", "<Leader>G", ":FzfLua live_grep_resume<CR>", { desc = "Resume last FzfLua file selector" })
		keymap.set("n", "<Leader>b", ":FzfLua git_branches<CR>", { desc = "Open FzfLua file selector" })
		keymap.set("n", "<Leader>q", ":FzfLua quickfix<CR>", { desc = "Open FzfLua file selector" })
		keymap.set("n", "<Leader>A", ":FzfInDir ", { desc = "Ask for a folder to start Fzflua content selector" })

		-- Custom commands
		-- Search in specified folder
		vim.api.nvim_create_user_command("FzfInDir", function(opts)
			require("fzf-lua").files({ cwd = opts.args })
		end, { nargs = 1, complete = "dir" })
	end,
}
