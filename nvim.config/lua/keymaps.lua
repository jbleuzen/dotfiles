-- keymaps
vim.g.mapleader = ','

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<F1>', '<nop>', {silent = true})
map('i', '<F1>', '<nop>', {silent = true})
map('v', '<F1>', '<nop>', {silent = true})

-- disabled arrow navigation
map('', '<up>', '<nop>', {noremap = true})
map('', '<down>', '<nop>', {noremap = true})
map('', '<left>', '<nop>', {noremap = true})
map('', '<right>', '<nop>', {noremap = true})

-- better indentation
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- better moving lines
map('n', 'È', ':m -2<CR>==', opts)
map('n', 'Ï', ':m +1<CR>==', opts)
map('i', 'È', ':m -2<CR>==gi', opts)
map('i', 'Ï', ':m +1<CR>==gi', opts)
map('v', 'Ï', ':m +1<CR>gv=gv', opts)
map('v', 'È', ':m -2<CR>gv=gv', opts)

-- reload
map('n', '<Leader>r', '<Cmd>lua ReloadConfig()<CR>', opts)

-- undotree
map('n', '<Leader>u', ':UndotreeToggle<CR>', opts)

-- resizing
map('n', '<Leader>)', ':vertical resize -5<CR>', opts)
map('n', '<Leader>-', ':vertical resize +5<CR>', opts)

-- tab movements
map('n', '<Left>', ':bp<CR>', {noremap = true})
map('n', '<Right>', ':bn<CR>', {noremap = true})
map('n', '<Leader>w', ':bn | bd#<CR>', {noremap = true})

-- quickfix
map('n', '<Leader>j', ':cnext<CR>', opts)
map('n', '<Leader>k', ':cprev<CR>', opts)

-- file tree
map('n', '<Leader>d', ':NvimTreeToggle<CR>', {noremap = true})
map('n', '<Leader>n', ':NvimTreeFindFile<CR>', {noremap = true})

-- lsp
map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
map('n', '<Leader>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
map('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)

-- fzf-lua
map('n', '<Leader>f', ':FzfLua files<CR>', opts)
map('n', '<leader>a', ":FzfLua live_grep<CR>", opts)
map('n', '<leader>q', ":FzfLua quickfix<CR>", opts)

-- nvim-tmux-navigation
map('n', "<C-h>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>", opts)
map('n', "<C-j>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>", opts)
map('n', "<C-k>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>", opts)
map('n', "<C-l>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>", opts)
map('n', "<C-Space>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>", opts)
