-- plugins 

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

return require('packer').startup({function(use)
  -- Packer can manage itself
  use ({ 'wbthomason/packer.nvim' })

  -- utils
  use ({ 'nvim-lua/plenary.nvim' })

  -- lsp
  use ({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  })

  -- completion
  use ({
    "hrsh7th/nvim-cmp",
    config = [[require('config.cmp')]],
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      -- "L3MON4D3/LuaSnip",
      "onsails/lspkind-nvim",
    }
  })
  
  -- treesitter
  use ({
    'nvim-treesitter/nvim-treesitter',
    config = [[require('config.treesitter')]]
  })

  -- fzf-lua
  use ({ 
    'ibhagwan/fzf-lua',
    config = [[require('config.fzf')]],
    -- optional for icon support
    requires = { 'nvim-tree/nvim-web-devicons' }
  })

  -- undotree
  use ({
    'mbbill/undotree',
    cmd = { 'UndotreeShow', 'UndotreeToggle', 'UndotreeHide', 'UndotreeFocus' }
  })

  -- nvim-surround
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  })

  -- comments
  use ({
    'terrortylor/nvim-comment',
    config = [[require('config.comment')]]
  })

  -- autopairs
  use ({
    'windwp/nvim-autopairs',
    config = [[require('config.autopairs')]],
    event = "InsertEnter",
  })

  -- colorscheme
  use ({
    'tanvirtin/monokai.nvim',
  })

  -- statusline
  use ({
    'nvim-lualine/lualine.nvim',
    config = [[require('config.lualine')]]
  })

  use { 
    'alexghergh/nvim-tmux-navigation', 
    config = function()
      require'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true, -- defaults to false
      }
    end
  }

  -- bufferline
  use ({
    'akinsho/bufferline.nvim',
    config = [[require('config.bufferline')]],
    requires = 'nvim-tree/nvim-web-devicons',
  })

  -- nvim tree
  use ({
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons',
    config = [[require('config.tree')]]
  })


  use {'famiu/bufdelete.nvim'}

  use({
    "folke/trouble.nvim",
    requires = 'nvim-tree/nvim-web-devicons',
    config = [[require('config.trouble')]]
  })

  use ({
    "lukas-reineke/indent-blankline.nvim",
    config = [[require('config.indent-blankline')]]
  })

  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    after = "nvim-web-devicons", -- keep this if you're using NvChad
    config = [[ require('config.barbecue') ]]
  })

  use 'tpope/vim-fugitive'

  use { 
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = [[ require('config.neogit') ]]
  }

  -- ccs colors
  -- use ({ 
  --   'norcalli/nvim-colorizer.lua',
  -- })

  -- startup time
  use ({
    'lewis6991/impatient.nvim',
    config = [[require('config.impatient')]]
  })
  
  use ({ 'tweekmonster/startuptime.vim' })

  require('config.lsp.init')

  end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
