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
vim.o.foldmethod = 'manual'
vim.o.foldtext = 'getline(v:foldstart) .. " "'
vim.o.title = true
vim.o.errorbells = false
vim.o.cursorline = true
vim.opt.updatetime = 200
vim.o.showmode = false -- Hide the mode in command line
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.completeopt = 'menuone,noselect,noinsert'
--vim.o.shortmess = 'c'
--vim.o.clipboard = 'unnamedplus'
vim.o.updatetime = 50
vim.o.signcolumn = 'yes'

vim.opt.ignorecase = true

vim.o.lazyredraw = true
vim.cmd([[ set diffopt+=iwhite,internal,algorithm:patience,vertical ]])

local cmd = vim.cmd

-- Enable the mouse
cmd [[set mouse=a]]


-- Allow to highlight what have been yanked
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Markdown
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    -- vim.opt_local.conceallevel = 2
    vim.opt_local.wrap = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})
