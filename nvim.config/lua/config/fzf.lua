local actions = require'fzf-lua.actions'

require('fzf-lua').setup({
  file_icon_padding = ' ',
  defaults = {
    cwd_prompt = false,
    header = false,
    file_icons = false,
    color_icons = false,
    winopts = {
      backdrop = 50,
      row = 0,
      height = .65,
      fullscreen = false,
      preview = {
        title = false,
      }
    },
  },
  keymap = {
    builtin = {
      ["<Esc>"] = "abort",
      ["<F1>"]     = "toggle-help",
      ["<F2>"]     = "toggle-fullscreen",
      ["<F3>"]     = "toggle-preview-wrap",
      -- nvim registers <C-/> as <C-_>, use insert mode
      -- and press <C-v><C-/> should output ^_
      ["<C- >"]    = "toggle-preview",
      ["<C-j>"] = "preview-page-down",
      ["<C-k>"] = "preview-page-up",
      ["<C-h>"] = "preview-page-reset",
      ["<C-l>"] = "preview-page-reset",
    },
  },
  grep = {
    prompt = " Search ❯ ",
  },
  files = {
    prompt = " Files ❯ ",
  },
  previewers = {
    builtin = {
      extensions = {
        -- neovim terminal only supports `viu` block output
        ["png"] = { "viu", "-b" },
        ["jpg"] = { "viu", "-b" }
      }      
    }
  },
  actions = {
    files = {
      -- instead of the default action 'actions.file_edit_or_qf'
      -- it's important to define all other actions here as this
      -- table does not get merged with the global defaults
      ["default"]       = actions.file_edit,
      ["ctrl-s"]        = actions.file_split,
      ["ctrl-v"]        = actions.file_vsplit,
      ["ctrl-t"]        = actions.file_tabedit,
      ["ctrl-q"]         = actions.file_sel_to_qf,
    },
  }
})
