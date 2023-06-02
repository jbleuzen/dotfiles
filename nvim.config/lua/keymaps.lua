-- keymaps
vim.g.mapleader = ','

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

--# PERSO --------------------------------------------------------------------------------

map('n', '<F1>', '<nop>', {silent = true})
map('i', '<F1>', '<nop>', {silent = true})
map('v', '<F1>', '<nop>', {silent = true})

-- disabled arrow navigation
map('', '<up>', '<nop>', {noremap = true})
map('', '<down>', '<nop>', {noremap = true})
map('', '<left>', '<nop>', {noremap = true})
map('', '<right>', '<nop>', {noremap = true})
map('i', '<up>', '<nop>', {noremap = true})
map('i', '<down>', '<nop>', {noremap = true})
map('i', '<left>', '<nop>', {noremap = true})
map('i', '<right>', '<nop>', {noremap = true})

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

-- Allow to return to the first char in command mode
map('c', '<C-a>', '<Home>', {silent = false})

-- reload
map('n', '<Leader>r', '<Cmd>lua ReloadConfig()<CR>', opts)

-- Delete all buffers
-- map('n', '<Leader>wa', ':bufdo bd!', opts)

-- Disable highlight for previous search
map('n', '<Leader>/', ':let @/ = ""<CR>', opts)

--# PLUGINS ------------------------------------------------------------------------------
-- undotree
map('n', '<Leader>u', ':UndotreeToggle<CR>', opts)

-- Trouble
map("n", "<F1>", ":TroubleToggle<CR>",opts)

-- Neogit
map("n", "<F2>", ":Neogit<CR>", opts)


local function showFugitiveGit()
  if vim.fn.FugitiveHead() ~= '' then
    vim.cmd [[
    Git
    autocmd User FugitiveBlob setlocal readonly nomodifiable noswapfile
    setlocal nonumber
    setlocal norelativenumber
    setlocal signcolumn=no
    ]]
  end
end
local function toggleFugitiveGit()
  if vim.fn.buflisted(vim.fn.bufname('fugitive:///*/.git//$')) ~= 0 then
    vim.cmd[[ execute ":bdelete" bufname('fugitive:///*/.git//$') ]]
  else
    showFugitiveGit()
  end
end
vim.cmd[[

 augroup Fugitive
      autocmd!
      autocmd FileType fugitive nnoremap <silent> <buffer> <F1> <Nop>
      autocmd FileType fugitive nnoremap <buffer> q <C-W>q
      autocmd FileType fugitive nnoremap <buffer> <Esc> <C-W>q
      autocmd FileType fugitive nmap <buffer> <C-N> )
      autocmd FileType fugitive nmap <buffer> <C-P> (
      autocmd FileType fugitive nmap <buffer> <Tab> =
    augroup END
]]
vim.keymap.set('n', '<F3>', toggleFugitiveGit, opts)

-- resizing
map('n', '<Leader>)', ':vertical resize -5<CR>', opts)
map('n', '<Leader>-', ':vertical resize +5<CR>', opts)

-- tab movements
map('n', '<left>', ':BufferLineCyclePrev<CR>', {noremap = true})
map('n', '<right>', ':BufferLineCycleNext<CR>', {noremap = true})
map('n', '<S-left>', ':BufferLineMovePrev<CR>', {noremap = true})
map('n', '<S-right>', ':BufferLineMoveNext<CR>', {noremap = true})
map('n', '<Leader>x', ':bufdo :Bdelete<CR>', {noremap = true})
map('n', '<Leader>w', ':Bdelete<CR>', {noremap = true})

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
map('n', '<Leader>s', ':lua vim.lsp.buf.rename()<CR>', opts)
map('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)

-- fzf-lua
map('n', '<Leader>f', ':FzfLua files<CR>', opts)
map('n', '<Leader>a', ":FzfLua live_grep<CR>", opts)
map('n', '<Leader>q', ":FzfLua quickfix<CR>", opts)

-- nvim-tmux-navigation
map('n', "<C-h>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>", opts)
map('n', "<C-j>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>", opts)
map('n', "<C-k>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>", opts)
map('n', "<C-l>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>", opts)
map('n', "<C-Space>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>", opts)
