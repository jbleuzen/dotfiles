return {
  "folke/trouble.nvim",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function() 
    require("trouble").setup {
      position = "bottom", -- position of the list can be: bottom, top, left, right
      height = 15, -- height of the trouble list when position is top or bottom
      width = 50, -- width of the list when position is left or right
      mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      fold_open = "", -- icon used for open folds
      fold_closed = "", -- icon used for closed folds
      group = true, -- group results by file
      padding = false, -- add an extra new line on top of the list
      focus = true,
      keys = {
         ["<Esc>"] = "close",
      },
      indent_lines = true, -- add an indent guide below the fold icons
      auto_open = false, -- automatically open the list when you have diagnostics
      auto_close = true, -- automatically close the list when you have no diagnostics
      auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      auto_fold = false, -- automatically fold a file trouble list at creation
      auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
      use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
    }

    -- keymaps
    local keymap = vim.keymap
    keymap.set("n", "<F1>", ":Trouble diagnostics toggle<CR>",{silent=true, noremap=true})

  end
}
