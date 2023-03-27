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

  use 'tpope/vim-fugitive'

  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim', config= function() 
    require'neogit'.setup {
      disable_signs = false,
      disable_hint = true,
      disable_context_highlighting = true,
      disable_commit_confirmation = false,
      -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
      -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
      auto_refresh = true,
      -- Value used for `--sort` option for `git branch` command
      -- By default, branches will be sorted by commit date descending
      -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
      -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
      sort_branches = "-committerdate",
      disable_builtin_notifications = false,
      use_magit_keybindings = false,
      -- Change the default way of opening neogit
      kind = "split",
      -- The time after which an output console is shown for slow running commands
      console_timeout = 2000,
      -- Automatically show console if a command takes more than console_timeout milliseconds
      auto_show_console = true,
      -- Persist the values of switches/options within and across sessions
      remember_settings = true,
      -- Scope persisted settings on a per-project basis
      use_per_project_settings = true,
      -- Array-like table of settings to never persist. Uses format "Filetype--cli-value"
      --   ie: `{ "NeogitCommitPopup--author", "NeogitCommitPopup--no-verify" }`
      ignored_settings = {},
      -- Change the default way of opening the commit popup
      commit_popup = {
        kind = "float",
      },
      -- Change the default way of opening the preview buffer
      preview_buffer = {
        kind = "split",
      },
      -- Change the default way of opening popups
      popup = {
        kind = "split",
      },
      -- customize displayed signs
      signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
      integrations = {
        -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
        -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
        --
        -- Requires you to have `sindrets/diffview.nvim` installed.
        -- use {
        --   'TimUntersberger/neogit',
        --   requires = {
        --     'nvim-lua/plenary.nvim',
        --     'sindrets/diffview.nvim'
        --   }
        -- }
        --
        diffview = false
      },
      -- Setting any section to `false` will make the section not render at all
      sections = {
        untracked = {
          folded = false
        },
        unstaged = {
          folded = false
        },
        staged = {
          folded = false
        },
        stashes = {
          folded = true
        },
        unpulled = {
          folded = true
        },
        unmerged = {
          folded = false
        },
        recent = {
          folded = true
        },
      },
      -- override/add mappings
      mappings = {
        -- modify status buffer mappings
        status = {
          -- Adds a mapping with "B" as key that does the "BranchPopup" command
          ["Space"] = "",
          ["B"] = "BranchPopup",
          -- Removes the default mapping of "s"
          ["s"] = "",
        }
      }
    }
  end
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
