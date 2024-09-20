local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 'u', api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '<Shift>Enter', api.tree.change_root_to_node,        opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end

require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
  reload_on_bufenter = true,
  on_attach = my_on_attach,
  view = {
    signcolumn = "yes",
  },
  actions = {
    change_dir = {
      restrict_above_cwd = true,
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
          unstaged = "•",
          staged = "+",
          unmerged = "",
          renamed = "→",
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
