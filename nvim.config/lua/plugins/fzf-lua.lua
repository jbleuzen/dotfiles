return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config= function()

    local actions = require'fzf-lua.actions'

    require('fzf-lua').setup({
      file_icon_padding = ' ',
      defaults = {
        cwd_prompt = false,
        header = false,
        file_icons = false,
        color_icons = true,
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
         input_prompt      = 'Grep For❯ ',
      },
      files = {
        prompt = " Files ❯ ",
      },
      git = {
        branches = {
          prompt = " GitBranch ❯ ",
          actions  = {
            ["default"] = actions.git_switch,
            ["ctrl-x"]  = { fn = actions.git_branch_del, reload = true },
            ["ctrl-a"]  = { fn = actions.git_branch_add, field_index = "{q}", reload = true },
          },
          cmd= "git branch",
          -- If you wish to add branch and switch immediately
          -- cmd_add  = { "git", "checkout", "-b" },
          cmd_add  = { "git", "branch" },
          -- If you wish to delete unmerged branches add "--force"
          -- cmd_del  = { "git", "branch", "--delete", "--force" },
          cmd_del  = { "git", "branch", "--delete" },
        },
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
          ["ctrl-q"]        = actions.file_sel_to_qf,
        },
      }
    })

    -- Keymaps
    local keymap = vim.keymap
    keymap.set('n', '<Leader>f', ':FzfLua files<CR>', {desc="Open FzfLua file selector"})
    keymap.set('n', '<Leader>k', ':FzfLua grep_cword<CR>', {desc="Open FzfLua file selector"})
    keymap.set('n', '<Leader>a', ":FzfLua live_grep<CR>", {desc="Open FzfLua file selector"})
    keymap.set('n', '<Leader>b', ":FzfLua git_branches<CR>", {desc="Open FzfLua file selector"})

  end
}
