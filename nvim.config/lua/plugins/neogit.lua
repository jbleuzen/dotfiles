return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"ibhagwan/fzf-lua", -- optional
		"m00qek/baleia.nvim", -- required for log_pager
	},
	config = function()
		vim.g.baleia = require("baleia").setup({})

		local function discreet_hunk_headers()
			vim.api.nvim_set_hl(0, "NeogitHunkHeader", { link = "Comment" })
			vim.api.nvim_set_hl(0, "NeogitHunkHeaderHighlight", { link = "Comment" })
			vim.api.nvim_set_hl(0, "NeogitHunkHeaderCursor", { link = "CursorLine" })
		end

		discreet_hunk_headers()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = discreet_hunk_headers })

		local function neogit_text_width()
			for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
				local buf = vim.api.nvim_win_get_buf(win)
				if vim.bo[buf].filetype:match("^Neogit") then
					local info = vim.fn.getwininfo(win)[1]
					return info.width - info.textoff
				end
			end
		end

		local function set_delta_width(width)
			local pager = require("neogit.config").values.log_pager
			if not pager then
				return false
			end
			for i, arg in ipairs(pager) do
				if arg == "--width" then
					local new = tostring(width)
					if pager[i + 1] == new then
						return false -- rien n'a changé
					end
					pager[i + 1] = new
					return true
				end
			end
			return false
		end

		local function refresh_status()
			local ok, status = pcall(require, "neogit.buffers.status")
			local instance = ok and status.instance()
			if instance then
				-- update_diffs force le recalcul des diffs (sinon Neogit garde son cache)
				instance:dispatch_refresh({ update_diffs = { "*:*" } }, "delta_resize")
			end
		end

		-- Debounce : un redimensionnement tmux génère une rafale d'événements
		local timer = vim.uv.new_timer()

		vim.api.nvim_create_autocmd({ "VimResized", "WinResized", "BufWinEnter" }, {
			callback = function()
				timer:stop()
				timer:start(
					150,
					0,
					vim.schedule_wrap(function()
						local width = neogit_text_width()
						if width and set_delta_width(width) then
							refresh_status()
						end
					end)
				)
			end,
		})

		local neogit = require("neogit")
		neogit.setup({
			-- Hides the hints at the top of the status buffer
			disable_hint = true,
			-- Disables changing the buffer highlights based on where the cursor is.
			disable_context_highlighting = false,
			-- Disables signs for sections/items/hunks
			disable_signs = false,
			-- Changes what mode the Commit Editor starts in. `true` will leave nvim in normal mode, `false` will change nvim to
			-- insert mode, and `"auto"` will change nvim to insert mode IF the commit message is empty, otherwise leaving it in
			-- normal mode.
			disable_insert_on_commit = "auto",
			-- When enabled, will watch the `.git/` directory for changes and refresh the status buffer in response to filesystem
			-- events.
			filewatcher = {
				interval = 1000,
				enabled = true,
			},
			-- "ascii"   is the graph the git CLI generates
			-- "unicode" is the graph like https://github.com/rbong/vim-flog
			graph_style = "unicode",
			--   -- When set, used to format the diff. Requires *baleia* to colorize text with ANSI escape sequences. An example for `Delta` is `{ 'delta', '--width', '117' }`. For `Delta`, hyperlinks must be disabled when called by `neogit`, for text to be colorized properly.
			log_pager = vim.fn.executable("delta") == 1 and {
				"delta",
				"--width",
				tostring(vim.o.columns),
				"--file-style",
				"omit",
				"--file-decoration-style",
				"none",
				"--hunk-header-style",
				"omit",
				"--hunk-header-decoration-style",
				"none",
			} or nil,
			-- Used to generate URL's for branch popup action "pull request".
			git_services = {
				["github.com"] = {
					pull_request = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
					commit = "https://github.com/${owner}/${repository}/commit/${oid}",
					tree = "https://${host}/${owner}/${repository}/tree/${branch_name}",
				},
				["bitbucket.org"] = {
					pull_request = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
					commit = "https://bitbucket.org/${owner}/${repository}/commits/${oid}",
					tree = "https://bitbucket.org/${owner}/${repository}/branch/${branch_name}",
				},
				["gitlab.com"] = {
					pull_request = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
					commit = "https://gitlab.com/${owner}/${repository}/-/commit/${oid}",
					tree = "https://gitlab.com/${owner}/${repository}/-/tree/${branch_name}?ref_type=heads",
				},
				["azure.com"] = {
					pull_request = "https://dev.azure.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}",
					commit = "",
					tree = "",
				},
			},
			-- Persist the values of switches/options within and across sessions
			remember_settings = true,
			-- Scope persisted settings on a per-project basis
			use_per_project_settings = true,
			-- Table of settings to never persist. Uses format "Filetype--cli-value"
			ignored_settings = {
				"NeogitPushPopup--force-with-lease",
				"NeogitPushPopup--force",
				"NeogitPullPopup--rebase",
				"NeogitCommitPopup--allow-empty",
				"NeogitRevertPopup--no-edit",
			},
			-- Configure highlight group features
			highlight = {
				italic = true,
				bold = true,
				underline = true,
			},
			-- Set to false if you want to be responsible for creating _ALL_ keymappings
			use_default_keymaps = true,
			-- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
			-- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
			auto_refresh = true,
			-- Value used for `--sort` option for `git branch` command
			-- By default, branches will be sorted by commit date descending
			-- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
			-- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
			sort_branches = "-committerdate",
			-- Change the default way of opening neogit
			kind = "tab",
			-- Disable line numbers and relative line numbers
			disable_line_numbers = true,
			-- The time after which an output console is shown for slow running commands
			console_timeout = 2000,
			-- Automatically show console if a command takes more than console_timeout milliseconds
			auto_show_console = true,
			-- Automatically close the console if the process exits with a 0 (success) status
			auto_close_console = true,
			status = {
				show_head_commit_hash = false,
				recent_commit_count = 0,
				HEAD_padding = 5,
				HEAD_folded = true,
				mode_padding = 10,
				mode_text = {
					M = " modified",
					N = " new file",
					A = " added",
					D = " deleted",
					C = " copied",
					U = " updated",
					R = " renamed",
					DD = " unmerged",
					AU = " unmerged",
					UD = " unmerged",
					UA = " unmerged",
					DU = " unmerged",
					AA = " unmerged",
					UU = " unmerged",
					["?"] = "",
				},
			},
			commit_editor = {
				kind = "floating",
				show_staged_diff = true,
				-- Accepted values:
				-- "split" to show the staged diff below the commit editor
				-- "vsplit" to show it to the right
				-- "split_above" Like :top split
				-- "vsplit_left" like :vsplit, but open to the left
				-- "auto" "vsplit" if window would have 80 cols, otherwise "split"
				staged_diff_split_kind = "split",
				spell_check = false,
			},
			commit_select_view = {
				kind = "tab",
			},
			commit_view = {
				kind = "vsplit",
				verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
			},
			log_view = {
				kind = "tab",
			},
			rebase_editor = {
				kind = "auto",
			},
			reflog_view = {
				kind = "tab",
			},
			merge_editor = {
				kind = "auto",
			},
			tag_editor = {
				kind = "auto",
			},
			preview_buffer = {
				kind = "floating",
			},
			popup = {
				kind = "floating",
			},
			signs = {
				-- { CLOSED, OPENED }
				hunk = { "", "" },
				item = { "", "" },
				section = { "", "" },
			},
			-- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
			integrations = {
				-- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
				-- The diffview integration enables the diff popup.
				diffview = true,
				-- If enabled, uses fzf-lua for menu selection.
				fzf_lua = true,
			},
			sections = {
				-- Reverting/Cherry Picking
				sequencer = {
					folded = false,
					hidden = false,
				},
				untracked = {
					folded = false,
					hidden = false,
				},
				unstaged = {
					folded = false,
					hidden = false,
				},
				staged = {
					folded = false,
					hidden = false,
				},
				stashes = {
					folded = true,
					hidden = true,
				},
				unpulled_upstream = {
					folded = true,
					hidden = false,
				},
				unmerged_upstream = {
					folded = false,
					hidden = true,
				},
				unpulled_pushRemote = {
					folded = true,
					hidden = false,
				},
				unmerged_pushRemote = {
					folded = false,
					hidden = false,
				},
				recent = {
					folded = true,
					hidden = false,
				},
				rebase = {
					folded = true,
					hidden = false,
				},
			},
			mappings = {
				commit_editor = {
					["q"] = "Close",
					["<S-CR>"] = "Submit",
					["<Esc>"] = "Abort",
				},
				commit_editor_I = {
					["<S-CR>"] = "Submit",
					-- ["<Esc>"] = "Abort",
				},
				rebase_editor = {
					["p"] = "Pick",
					["r"] = "Reword",
					["e"] = "Edit",
					["s"] = "Squash",
					["f"] = "Fixup",
					["x"] = "Execute",
					["d"] = "Drop",
					["b"] = "Break",
					["q"] = "Close",
					["<cr>"] = "OpenCommit",
					["gk"] = "MoveUp",
					["gj"] = "MoveDown",
					["<c-c><c-c>"] = "Submit",
					["<c-c><c-k>"] = "Abort",
					["[c"] = "OpenOrScrollUp",
					["]c"] = "OpenOrScrollDown",
				},
				rebase_editor_I = {
					["<c-c><c-c>"] = "Submit",
					["<c-c><c-k>"] = "Abort",
				},
				finder = {
					["<cr>"] = "Select",
					["<c-c>"] = "Close",
					["<esc>"] = "Close",
					["<c-n>"] = "Next",
					["<c-p>"] = "Previous",
					["<down>"] = "Next",
					["<up>"] = "Previous",
					["<tab>"] = "MultiselectToggleNext",
					["<s-tab>"] = "MultiselectTogglePrevious",
					["<c-j>"] = "NOP",
				},
				-- Setting any of these to `false` will disable the mapping.
				popup = {
					["?"] = "HelpPopup",
					["A"] = "CherryPickPopup",
					["D"] = "DiffPopup",
					["M"] = "RemotePopup",
					["P"] = "PushPopup",
					["X"] = "ResetPopup",
					["Z"] = "StashPopup",
					["b"] = "BranchPopup",
					["B"] = "BisectPopup",
					["c"] = "CommitPopup",
					["f"] = "FetchPopup",
					["l"] = "LogPopup",
					["m"] = "MergePopup",
					["p"] = "PullPopup",
					["r"] = "RebasePopup",
					["v"] = "RevertPopup",
					["w"] = "WorktreePopup",
				},
				status = {
					["k"] = "MoveUp",
					["j"] = "MoveDown",
					["q"] = "Close",
					["<Esc>"] = "Close",
					["o"] = "OpenTree",
					["I"] = "InitRepo",
					["1"] = "Depth1",
					["2"] = "Depth2",
					["3"] = "Depth3",
					["4"] = "Depth4",
					["<tab>"] = "Toggle",
					["<space>"] = "Toggle",
					["x"] = "Discard",
					["s"] = "Stage",
					["+"] = "Stage",
					["S"] = "StageUnstaged",
					["<c-s>"] = "StageAll",
					["K"] = "Untrack",
					["u"] = "Unstage",
					["-"] = "Unstage",
					["U"] = "UnstageStaged",
					["$"] = "CommandHistory",
					["Y"] = "YankSelected",
					["<c-r>"] = "RefreshBuffer",
					["<enter>"] = "GoToFile",
					["<c-v>"] = "VSplitOpen",
					["<c-x>"] = "SplitOpen",
					["<c-t>"] = "TabOpen",
					["{"] = "GoToPreviousHunkHeader",
					["}"] = "GoToNextHunkHeader",
				},
			},
		})

		-- Keymaps
		local function toggleNeogit()
			if vim.bo.filetype == "NeogitStatus" then
				require("neogit").close()
			else
				require("neogit").open()
			end
		end
		vim.keymap.set("n", "<F2>", toggleNeogit, { silent = true, noremap = true })

		-- Remaps enter to open file from git log history
		vim.api.nvim_create_autocmd("BufWinEnter", {
			callback = function(args)
				if vim.bo[args.buf].filetype == "NeogitCommitView" then
					vim.keymap.set("n", "<CR>", "a", { buffer = args.buf, remap = true })
				end
			end,
		})
	end,
}
