-- settings

vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.joinspaces = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.smartcase = true
vim.o.scrolloff = 2
vim.o.hidden = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true
vim.o.undodir = '/tmp/.cache-nvim-undodir'
vim.o.backspace = 'indent,eol,start'
vim.o.foldmethod = 'marker'
vim.o.title = true
vim.o.errorbells = false
vim.o.cursorline = true
vim.o.showmode = false -- Hide the mode in command line
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.completeopt = 'menuone,noselect,noinsert'
--vim.o.shortmess = 'c'
--vim.o.clipboard = 'unnamedplus'
vim.o.updatetime = 50
vim.o.signcolumn = 'yes'

vim.o.lazyredraw = true
vim.cmd([[ set diffopt+=iwhite,internal,algorithm:patience ]])

local cmd = vim.cmd

-- Enable the mouse
cmd [[set mouse=a]]

local monokai = require('monokai')
local palette = monokai.soda

monokai.setup {
  palette = {
    base2 = "#000000"
  },
  custom_hlgroups = {
    Normal = {
      bg = "#000000"
    },
    NormalNC = {
      bg = "#1C1C1C",
    },
    CursorLineNr = {
      bg = "#303030",
      fg = "#FF8700"
    },
    LineNr = {
      bg = "#202020",
      fg = "#666666",
    },
    SignColumn = {
      bg = "#202020",
      fg = "#666666",
    },
    CursorLineSign = {
      bg = "#303030",
      fg = "#BCBCBC",
    },
    -- lsp
    DiagnosticSignInfo = {
      bg = "#202020",
    },
    DiagnosticSignHint = {
      bg = "#202020",
    },
    DiagnosticSignWarn = {
      bg = "#202020",
    },
    DiagnosticSignError = {
      bg = "#202020",
    },
    -- nvim-tree
    NvimTreeNormal = {
      bg = "#000000"
    },
    NvimTreeNormalNC = {
      bg = "#1C1C1C"
    },
    NvimTreeIndentMarker = {
      fg= "#333333"
    },
    NvimTreeRootFolder = {
      fg = palette.base8,
      bg = "#00FF00"
    },
    NvimTreeFolderName = {
      fg = palette.green,
    },
    NvimTreeFolderIcon = {
      fg = palette.green,
    },
    NvimTreeEndOfBuffer = {
      fg= "#000000",
      bg = "#000000"
      },
    NvimTreeOpenedFolderName = {
      fg = palette.green,
    },
    NvimTreeSpecialFile = {
      fg = palette.purple
    },
    NvimTreeSymlink = {
      fg = palette.aqua,
    },
    NvimTreeGitDirty = {
      fg=palette.green,
      bg="#000000"
    },
    -- FZF
    FZFLuaBorder = {
      fg = "#666666"
    },
    -- Trouble 
    TroubleTextError = {
      fg = "#D75F87"
    },
    TroubleTextWarning = {
      fg = "#D7D787"
    },
    TroubleTextHint = {
      fg = "#D75F87"
    },
    TroubleFoldIcon = {
      fg = "#FFFFFF"
    },
    TroubleFile = {
      fg = "#FFFFFF"
    }
  }
}


-- Change the background color of inactive pane/window
cmd [[
  autocmd FocusGained * hi Normal guibg=#000000 | hi NvimTreeNormal guibg=#000000
  autocmd FocusLost * hi Normal guibg=#1C1C1C | hi NvimTreeNormal guibg=#1C1C1C | hi NvimTreeEndOfBuffer guifg=#1C1C1C guibg=#1C1C1C
]]

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function(opts)
    if vim.bo[opts.buf].filetype == "NvimTree" then
      cmd[[
        hi NvimTreeEndOfBuffer guifg=#000000 guibg=#000000
        hi NvimTreeGitDirty guibg=#000000
        hi NvimTreeSignColumn guifg=#000000 guibg=#000000
        hi NvimTreeGitNew guibg=#000000
        hi NvimTreeGitAdded guibg=#000000
        hi NvimTreeGitDeleted guibg=#000000
        hi NvimTreeGitMerge guibg=#000000
        hi NvimTreeGitIgnored guibg=#000000
        hi NvimTreeGitStaged guibg=#000000
      ]]
    end
    if vim.bo[opts.buf].filetype == "Trouble" then
      cmd[[
        hi TroubleNormal guibg=#000000 
      ]]
    end
  end,
  group = nt_au_group,
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
  pattern = "*",
  callback = function(opts)
    if vim.bo[opts.buf].filetype == "NvimTree" then
      cmd[[
        hi NvimTreeEndOfBuffer guifg=#1C1C1C guibg=#1C1C1C
        hi NvimTreeGitDirty guibg=#1C1C1C
        hi NvimTreeSignColumn guifg=#1C1C1C guibg=#1C1C1C
        hi NvimTreeGitNew guibg=#1C1C1C
        hi NvimTreeGitAdded guibg=#1C1C1C
        hi NvimTreeGitDeleted guibg=#1C1C1C
        hi NvimTreeGitMerge guibg=#1C1C1C
        hi NvimTreeGitIgnored guibg=#1C1C1C
        hi NvimTreeGitStaged guibg=#1C1C1C
      ]]
    end
    if vim.bo[opts.buf].filetype == "Trouble" then
      cmd[[
        hi TroubleNormal guibg=#1C1C1C
      ]]
    end
  end,
  group = nt_au_group,
})


-- Allow to highlight what have been yanked
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Trouble
vim.keymap.set("n", "<F1>", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
