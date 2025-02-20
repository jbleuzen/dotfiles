local keymap = vim.keymap
local keymapOpts = {
	silent = true,
}

return {

	-- Utility lib for plugins
	"nvim-lua/plenary.nvim",

	-- Default icons
	"nvim-tree/nvim-web-devicons",

	-- undotree
	{
		"mbbill/undotree",
		config = function()
			-- Keymaps
			keymap.set("n", "<F3>", ":UndotreeToggle<CR>", keymapOpts)
		end,
	},

	-- Bufdelete
	-- {'famiu/bufdelete.nvim',
	--   config = function()
	--     -- Keymaps
	--     keymap.set('n', '<Leader>x', ':bufdo :Bdelete<CR>', keymapOpts)
	--     keymap.set('n', '<Leader>w', ':Bdelete<CR>', keymapOpts)
	--   end
	-- },

	{
		"j-hui/fidget.nvim",
	},

	{
		"FabijanZulj/blame.nvim",
		opts = {
			date_format = "%d/%m/%y",
			virtual_style = "right_align",
			-- views = {
			--   window = window_view,
			--   virtual = virtual_view,
			--   default = window_view,
			-- },
			focus_blame = true,
			merge_consecutive = false,
			max_summary_width = 30,
			colors = nil,
			blame_options = nil,
			commit_detail_view = "vsplit",
			-- format_fn = formats.commit_date_author_fn,
			mappings = {
				commit_info = "i",
				stack_push = "<TAB>",
				stack_pop = "<BS>",
				show_commit = "<CR>",
				close = { "<esc>", "q" },
			},
		},
	},
}
