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
-- vim.o.cursorcolumn = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.completeopt = 'menuone,noselect,noinsert'
--vim.o.shortmess = 'c'
vim.o.clipboard = 'unnamedplus'
vim.o.updatetime = 50
vim.o.signcolumn = 'yes'

vim.o.lazyredraw = true

-- Enable the mouse
vim.cmd [[set mouse=a]]

-- require("onedarkpro").setup({
--   dark_theme = "onedarkdark", -- The default dark theme
--   highlights = {
--     NormalNC = "#FF00FF"
--   },
--   options = {
--     window_unfocused_color = true
--   }
-- })
-- vim.cmd("colorscheme onedarkpro")

local monokai = require('monokai')
local palette = monokai.soda

monokai.setup {
    palette = {
        base2 = '#000000',
    },
    custom_hlgroups = {
      -- nvim-tree
        NvimTreeFolderName = {
          fg = palette.green,
        },
        NvimTreeRootFolder = {
          fg = palette.base8,
        },
        NvimTreeFolderIcon = {
          fg = palette.green,
        },
        NvimTreeOpenedFolderName = {
          fg = palette.aqua,
        },
        NvimTreeFileIcon = {
          fg = palette.aqua,
        },
        NvimTreeSpecialFile = {
          fg = palette.purple
        },
        NvimTreeSymlink = {
          fg = palette.green,
        },
    }
}

local cmd = vim.cmd

-- Change the background color  of inactive pane/window
cmd [[
  autocmd WinEnter,FocusGained * hi Normal guibg=#000000 | hi LineNr guibg=#000000 | hi SignColumn guibg=#000000 | hi CursorLineNr guibg=#000000
  autocmd WinLeave,FocusLost * hi Normal guibg=#1C1C1C | hi LineNr guibg=#1C1C1C | hi SignColumn guibg=#1C1C1C | hi CursorLineNr guibg=#1C1C1C
]]

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
