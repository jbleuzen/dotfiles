return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	config = function()
		require("snacks").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
		})

		vim.keymap.set("n", "<leader>w", function()
			vim.cmd(":lua Snacks.bufdelete()")
		end, { desc = "Delete buffer" })

		vim.keymap.set("n", "<leader>W", function()
			vim.cmd(":lua Snacks.bufdelete({ force = true})")
		end, { desc = "Force delete buffer" })

		vim.keymap.set("n", "<leader>x", function()
			vim.cmd(":lua Snacks.bufdelete.all()")
		end, { desc = "Delete all buffers" })
	end,
}
