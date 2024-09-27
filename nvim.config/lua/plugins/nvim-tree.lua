return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require'nvim-tree'.setup {
      reload_on_bufenter = true,
      view = {
        signcolumn = "yes",
      },
      actions = {
        change_dir = {
          restrict_above_cwd = false,
        },
      },
      renderer = {
        add_trailing = false,
        special_files= { 'package.json' },
        root_folder_label = false,
        icons = {
          git_placement = "signcolumn",
          show={
            file = false,
            folder = false,
            folder_arrow = true,
            git = true,
            bookmarks = false,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            git = {
              unstaged = "●",
              staged = "+",
              unmerged = "",
              renamed = "➜",
              untracked = "?",
              deleted = "-",
              ignored = "◌",
            },
          },
        },
      },
      filters = {
        dotfiles = true,
        custom = { "Icon\r" }, -- Hides MacOS Icon files
        exclude = { }
      },
    }

    -- Keymaps
    local keymap = vim.keymap
    keymap.set('n', '<Leader>n', ':NvimTreeFindFile<CR>', {desc="Open file tree to the current file", silent = true})
    keymap.set('n', '<Leader>d', ':NvimTreeToggle<CR>', {desc = "Toggle file tree", silent = true})

  end 
}
