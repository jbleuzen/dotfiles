return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local api = require("nvim-tree.api")

		-- Sync cwd with nvim-tree folder
		local function nvim_tree_on_attach(bufnr)
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end
			--
			-- default mappings
			api.config.mappings.default_on_attach(bufnr)
			--
			-- custom mappings
			local function change_root_to_node(node)
				if node == nil then
					node = api.tree.get_node_under_cursor()
				end
				if node ~= nil and node.type == "directory" then
					vim.api.nvim_set_current_dir(node.absolute_path)
				end
				api.tree.change_root_to_node(node)
			end

			local function change_root_to_parent(node)
				local abs_path
				if node == nil then
					abs_path = api.tree.get_nodes().absolute_path
				else
					abs_path = node.absolute_path
				end

				local parent_path = vim.fs.dirname(abs_path)
				vim.api.nvim_set_current_dir(parent_path)
				api.tree.change_root(parent_path)
			end

			vim.keymap.set("n", "<Space>", change_root_to_node, opts("CD"))
			vim.keymap.set("n", "-", change_root_to_parent, opts("Up"))
		end

		require("nvim-tree").setup({
			on_attach = nvim_tree_on_attach,
			reload_on_bufenter = true,
			-- sync_root_with_cwd = true,
			view = {
				signcolumn = "yes",
			},
			actions = {
				change_dir = {
					restrict_above_cwd = true,
				},
			},
			renderer = {
				add_trailing = false,
				special_files = { "package.json" },
				root_folder_label = false,
				icons = {
					git_placement = "signcolumn",
					show = {
						file = false,
						folder = false,
						folder_arrow = true,
						git = true,
						bookmarks = false,
					},
					glyphs = {
						default = "",
						symlink = "",
						bookmark = "",
						git = {
							unstaged = "●",
							staged = "+",
							unmerged = "",
							renamed = "➜",
							untracked = "?",
							deleted = "-",
							ignored = "◌",
						},
					},
				},
			},
			filters = {
				dotfiles = true,
				custom = { "Icon\r" }, -- Hides MacOS Icon files
				exclude = {},
			},
		})

		-- Keymaps
		local keymap = vim.keymap
		keymap.set(
			"n",
			"<Leader>n",
			":NvimTreeFindFile<CR>",
			{ desc = "Open file tree to the current file", silent = true }
		)
		keymap.set("n", "<Leader>d", ":NvimTreeToggle<CR>", { desc = "Toggle file tree", silent = true })
		-- keymap.set("n", "<Space>", api.tree.change_root_to_node, { desc = "CD file tree", silent = true })
		keymap.set("n", "?", api.tree.toggle_help, { desc = "Toggle nvim-tree help", silent = true })

		-- -- custom mappings
		-- local function change_root_to_node(node)
		-- 	if node == nil then
		-- 		node = api.tree.get_node_under_cursor()
		-- 	end
		-- 	if node ~= nil and node.type == "directory" then
		-- 		vim.api.nvim_set_current_dir(node.absolute_path)
		-- 	end
		-- 	api.tree.change_root_to_node(node)
		-- end
		--
		-- local function change_root_to_parent(node)
		-- 	local abs_path
		-- 	if node == nil then
		-- 		abs_path = api.tree.get_nodes().absolute_path
		-- 	else
		-- 		abs_path = node.absolute_path
		-- 	end
		--
		-- 	local parent_path = vim.fs.dirname(abs_path)
		-- 	vim.api.nvim_set_current_dir(parent_path)
		-- 	api.tree.change_root(parent_path)
		-- end
		--
		-- keymap.set("n", "<Space>", change_root_to_node, { desc = "CD", silent = true })
		-- keymap.set("n", "-", change_root_to_parent, { desc = "Up", silent = true })
	end,
}
