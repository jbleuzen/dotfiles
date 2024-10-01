-- keymaps
-- This mapping MUST be done before initializing Lazy
vim.g.mapleader = ','
vim.g.maplocalleader = "\\"

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }


local function handleEscape()
  if vim.bo.filetype == "trouble" then
    vim.cmd("TroubleClose")
  end
  if vim.bo.filetype == "NvimTree" then
    vim.cmd("NvimTreeClose")
  end
  if vim.bo.filetype == "NeogitStatus" then
    require'neogit'.close()
  end
  if vim.bo.filetype == "qf" then
    vim.cmd("cclose")
  end
  if vim.bo.filetype == "DiffviewFiles" then
    vim.cmd("DiffviewClose")
  end
  if vim.bo.filetype == "undotree" then
    vim.cmd("UndotreeToggle")
  end
end
vim.keymap.set("n", "<Esc>", handleEscape, {silent = true, noremap= true})

-- Don't accidentally open :help
map('n', '<F1>', '<nop>', opts)
map('i', '<F1>', '<nop>', opts)
map('v', '<F1>', '<nop>',opts)

-- Disable arrow navigation
map('', '<up>', '<nop>', opts)
map('', '<down>', '<nop>', opts)
map('', '<left>', '<nop>', opts)
map('', '<right>', '<nop>', opts)
map('i', '<up>', '<nop>', opts)
map('i', '<down>', '<nop>', opts)
map('i', '<left>', '<nop>', opts)
map('i', '<right>', '<nop>', opts)

-- Better navigation
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)

-- Better indentation
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Better moving lines
map('n', 'È', ':m -2<CR>==', opts)
map('n', 'Ï', ':m +1<CR>==', opts)
map('i', 'È', '<Esc>:m -2<CR>==gi', opts)
map('i', 'Ï', '<Esc>:m +1<CR>==gi', opts)
map('v', 'Ï', ':m +1<CR>gv=gv', opts)
map('v', 'È', ':m -2<CR>gv=gv', opts)

-- Allow to return to the first char in command mode
map('c', '<C-a>', '<Home>', opts)

-- Disable highlight for previous search
map('n', '<Leader>/', ':let @/ = ""<CR>', opts)

-- Better resizing
map('n', '<Leader>)', ':vertical resize -5<CR>', opts)
map('n', '<Leader>-', ':vertical resize +5<CR>', opts)

-- Quickfix
map('n', '<Leader>j', ':cnext<CR>', opts)
map('n', '<Leader>k', ':cprev<CR>', opts)

-- Disable mouse horizontal scrolling
map('n', '<ScrollWheelLeft>', '<nop>',opts)
map('n', '<ScrollWheelRight>', '<nop>',opts)
