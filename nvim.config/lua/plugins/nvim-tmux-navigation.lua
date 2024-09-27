return { 'alexghergh/nvim-tmux-navigation', 
  config = function()
    require'nvim-tmux-navigation'.setup {
      disable_when_zoomed = true, -- defaults to false
    }

    -- Keymaps
    local keymap = vim.keymap
    local keymapOpts = { 
      silent = true
    }

    keymap.set('n', "<C-h>", ":NvimTmuxNavigateLeft<CR>", keymapOpts)
    keymap.set('n', "<C-j>", ":NvimTmuxNavigateDown<CR>", keymapOpts)
    keymap.set('n', "<C-k>", ":NvimTmuxNavigateUp<CR>", keymapOpts)
    keymap.set('n', "<C-l>", ":NvimTmuxNavigateRight<CR>", keymapOpts)
    keymap.set('n', "<C-Space>", ":NvimTmuxNavigateLastActive<CR>", keymapOpts)
  end
}
