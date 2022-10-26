
require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  reload_on_bufenter = true,
  view = {
    signcolumn = "yes",
    hide_root_folder = true,
  },
  actions = {
    change_dir = {
      restrict_above_cwd = true,
    },
  },
  renderer = {
    add_trailing = false,
    special_files= { 'package.json' },
    icons = {
      git_placement = "signcolumn",
      show={
        file = false,
        folder = true,
        folder_arrow = false,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
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