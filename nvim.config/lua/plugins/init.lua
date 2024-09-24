return {

  -- Utility lib for plugins
  'nvim-lua/plenary.nvim', 
  -- Default icon
  'nvim-tree/nvim-web-devicons',

  -- TMUX
  { 'alexghergh/nvim-tmux-navigation', 
    config = function()
      require'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
          next = "<C-Space>",
        }
      }
    end
  },

  -- undotree
  'mbbill/undotree',
  -- cmd = { 'UndotreeShow', 'UndotreeToggle', 'UndotreeHide', 'UndotreeFocus' }

  'famiu/bufdelete.nvim',

  -- ccs colors
  --   'norcalli/nvim-colorizer.lua',

  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  }


}
