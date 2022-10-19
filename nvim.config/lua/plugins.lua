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

return require('packer').startup(function(use)
  -- Packer can manage itself
  use ({ 'wbthomason/packer.nvim' })

  use({ 'rktjmp/lush.nvim' })

  -- utils
  use ({ 'nvim-lua/plenary.nvim' })

  -- lsp
  use ({
    "neovim/nvim-lspconfig",
    config = [[require('config.lsp.init')]],
  })
  use ({'williamboman/nvim-lsp-installer'})
  use({'jose-elias-alvarez/nvim-lsp-ts-utils'})
  use({'jose-elias-alvarez/null-ls.nvim'})
  use({'MunifTanjim/eslint.nvim'})

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

  use { 'ibhagwan/fzf-lua',
      config = [[require('config.fzf')]],

  -- optional for icon support
  requires = { 'kyazdani42/nvim-web-devicons' }
}
  -- telescope

  -- use ({ 'nvim-lua/popup.nvim' })
  -- use ({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  -- use ({
  --   'nvim-telescope/telescope.nvim',
  --   config = [[require('config.telescope')]],
  -- })

  -- undotree
  use ({
    'mbbill/undotree',
    cmd = { 'UndotreeShow', 'UndotreeToggle', 'UndotreeHide', 'UndotreeFocus' }
  })

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
  use ( {
    "olimorris/onedarkpro.nvim"
  }) 

  use ({
    'jbleuzen/monokai.nvim',
  })

  use ({
    'folke/tokyonight.nvim',
  })

  use ({
    'rebelot/kanagawa.nvim',
  })

  -- statusline
  use ({
    'nvim-lualine/lualine.nvim',
    config = [[require('config.lualine')]]
  })

  use { 'alexghergh/nvim-tmux-navigation', config = function()
    require'nvim-tmux-navigation'.setup {
      disable_when_zoomed = true, -- defaults to false
    }
  end
}

-- bufferline
use ({
  'akinsho/bufferline.nvim',
  config = [[require('config.bufferline')]],
  requires = 'kyazdani42/nvim-web-devicons',
})

-- nvim tree
use ({
  'kyazdani42/nvim-tree.lua',
  cmd = {
    "NvimTreeClipboard",
    "NvimTreeClose",
    "NvimTreeFindFile",
    "NvimTreeOpen",
    "NvimTreeRefresh",
    "NvimTreeToggle",
  },
  requires = 'kyazdani42/nvim-web-devicons',
  config = [[require('config.tree')]]
})

-- ccs colors
use ({ 
  'norcalli/nvim-colorizer.lua',
})

-- startup time
use ({
  'lewis6991/impatient.nvim',
  config = [[require('config.impatient')]]
})

use ({ 'tweekmonster/startuptime.vim' })

end)

