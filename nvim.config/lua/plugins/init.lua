local keymap = vim.keymap
local keymapOpts = { 
  silent = true
}

return {

  -- Utility lib for plugins
  'nvim-lua/plenary.nvim', 

  -- Default icons
  'nvim-tree/nvim-web-devicons',

  -- undotree
  {'mbbill/undotree',
    config = function()
      -- Keymaps 
      keymap.set('n', '<Leader>u', ':UndotreeToggle<CR>', keymapOpts)
    end
  },

  -- Bufdelete
  {'famiu/bufdelete.nvim',
    config = function()
      -- Keymaps
      keymap.set('n', '<Leader>x', ':bufdo :Bdelete<CR>', keymapOpts)
      keymap.set('n', '<Leader>w', ':Bdelete<CR>', keymapOpts)
    end
  },

  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  }

}
